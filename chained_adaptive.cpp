#include "chained_adaptive.h"

ChainedAdaptive::ChainedAdaptive() {
    this->hashpower = -1; // not initialized
    this->hmsize = 0;
    this->cardinality = 0;
    this->dict = NULL;
    this->entries = NULL;
    this->accessesDict = NULL;
    this->accesses = NULL;
    this->entriesOffset = 0;
    this->u0 = this->v0 = this->w0 = -1;
    this->u1 = this->v1 = this->w1 = -1;
    this->mode = ADAPTIVE;
}

void ChainedAdaptive::initHashpower(int hashpower) {
    this->hashpower = hashpower;
    this->hmsize = pow(2, hashpower);
    this->dict = (KV**)malloc(sizeof(KV*)*hmsize);
    this->entries = (KV*)malloc(sizeof(KV)*hmsize*1.5); // safety factor
    this->accessesDict = (Acc**)malloc(sizeof(Acc*)*hmsize);
    this->accesses = (Acc*)malloc(sizeof(Acc)*hmsize*1.5); // safety factor
    memset(this->dict, 0, sizeof(KV*)*hmsize);
    memset(this->entries, 0, sizeof(KV)*hmsize*1.5);
    memset(this->accessesDict, 0, sizeof(Acc*)*hmsize);
    memset(this->accesses, 0, sizeof(Acc)*(hmsize*1.5+1));
    entriesOffset = 0;
    epochSize = hmsize/float(epoch_size_factor);
    mode = ADAPTIVE;
    numReqsSlab = epochSize;
    displacement = 0;
    displacement_sq = 0;
}

void ChainedAdaptive::bulkLoad(ulong *keys, ulong num_keys) {
    for (ulong i=0; i<num_keys; i++) {
        _setFinal(keys[i], _random());
    }
    this->cardinality = num_keys;
}

ulong ChainedAdaptive::processRequests(HashmapReq *reqs, ulong count) {
    ulong time_elapsed_us;
    clock_gettime(CLOCK_MONOTONIC, &startTime);
    ulong i = 0, j;
    ulong countReal = count;
    // make this a multiple of 10, to avoid inner for loop check for i < count
    count = count - (count % 10);
    while(i < count) {
        if (mode == ADAPTIVE) {
            while (numReqs < numReqsSlab && i<count) {
                for (j=0; j<10; j++,i++) {
                    switch (reqs[i].reqType) {
                        case FETCH_REQ:
                            _fetchAdaptive(&reqs[i]);
                            break;
                        case INSERT_REQ:
                            _insert(&reqs[i]);
                            break;
                        case DELETE_REQ:
                            _delete(&reqs[i]);
                            break;
                        case UPDATE_REQ:
                            _update(&reqs[i]);
                            break;
                        default:
                            break;
                    }
                }
            }
            if (i == count) break;
            numReqsSlab += sample_size;
            mode = BENCHMARKING;
            displacement = 0;
            displacement_sq = 0;
        }
        if (mode == BENCHMARKING) {
            while (numReqs < numReqsSlab && i<count) {
                for (j=0; j<10; j++, i++) {
                    switch (reqs[i].reqType) {
                        case FETCH_REQ:
                            _fetchBenchmark(&reqs[i]);
                            break;
                        case INSERT_REQ:
                            _insert(&reqs[i]);
                            break;
                        case DELETE_REQ:
                            _delete(&reqs[i]);
                            break;
                        case UPDATE_REQ:
                            _update(&reqs[i]);
                            break;
                        default:
                            break;
                    }
                }
            }
            if (i == count) break;
            // Calculate u0, v0, w0
            numReqsSlab += epochSize*(periodicity - 1);
            mode = DEFAULT;
        }
        if (mode == DEFAULT) {
            while (numReqs < numReqsSlab && i<count) {
                for (j=0; j<10; j++, i++) {
                    switch (reqs[i].reqType) {
                        case FETCH_REQ:
                            _fetchDefault(&reqs[i]);
                            break;
                        case INSERT_REQ:
                            _insert(&reqs[i]);
                            break;
                        case DELETE_REQ:
                            _delete(&reqs[i]);
                            break;
                        case UPDATE_REQ:
                            _update(&reqs[i]);
                            break;
                        default:
                            break;
                    }
                }
            }
            if (i == count) break;
            numReqsSlab += sample_size;
            mode = SENSING;
            displacement = 0;
            displacement_sq = 0;
        }
        if (mode == SENSING) {
            while (numReqs < numReqsSlab && i<count) {
                for (j=0; j<10; j++, i++) {
                    switch (reqs[i].reqType) {
                        case FETCH_REQ:
                            _fetchBenchmark(&reqs[i]);
                            break;
                        case INSERT_REQ:
                            _insert(&reqs[i]);
                            break;
                        case DELETE_REQ:
                            _delete(&reqs[i]);
                            break;
                        case UPDATE_REQ:
                            _update(&reqs[i]);
                            break;
                        default:
                            break;
                    }
                }
            }
            if (i == count) break;
            // calculate u1, v1, w1, and compare to u0, v0, w0
            numReqsSlab += epochSize;
            mode = ADAPTIVE;
            // otherwise mode=DEFAULT
        }
    }
    // Handle the remaining requests countReal - count, should be < 10
    for (; i<countReal; i++) {
        switch (reqs[i].reqType) {
            case FETCH_REQ:
                _fetchDefault(&reqs[i]);
                break;
            case INSERT_REQ:
                _insert(&reqs[i]);
                break;
            case DELETE_REQ:
                _delete(&reqs[i]);
                break;
            case UPDATE_REQ:
                _update(&reqs[i]);
                break;
            default:
                break;
        }
    }
    clock_gettime(CLOCK_MONOTONIC, &endTime);
    time_elapsed_us = _getTimeDiff(startTime, endTime);
    return time_elapsed_us;
}

void ChainedAdaptive::rehash() {
    if (cardinality < hmsize && cardinality > 0.5*hmsize) {
        return;
    }
    cout << "Rehashing triggered at cardinality " << this->cardinality << endl;
    KV* old_entries = entries;
    KV** old_dict = dict;
    Acc* old_accesses = accesses;
    Acc** old_accesses_dict= accessesDict;
    ulong old_hmsize = hmsize;
    this->hashpower = _getHashpower();
    hmsize = pow(2, hashpower);
    dict = (KV**)malloc(sizeof(KV*)*hmsize);
    entries = (KV*)malloc(sizeof(KV)*hmsize*1.5);
    accessesDict = (Acc**)malloc(sizeof(Acc*)*hmsize);
    accesses = (Acc*)malloc(sizeof(Acc)*hmsize*1.5);
    memset(this->dict, 0, sizeof(KV*)*hmsize);
    memset(this->entries, 0, sizeof(KV)*hmsize*1.5);
    memset(this->accessesDict, 0, sizeof(Acc*)*hmsize);
    memset(this->accesses, 0, sizeof(Acc)*hmsize*1.5);
    entriesOffset = 0;

    KV* ptr;
    for (ulong i=0; i<old_hmsize; i++) {
        ptr = old_dict[i];
        while (ptr != NULL) {
            _setFinalEnd(ptr->key, ptr->value);
            ptr = ptr->next;
        }
    }
    std::free(old_entries);
    std::free(old_dict);
    std::free(old_accesses_dict);
    std::free(old_accesses);
}

void ChainedAdaptive::free() {
    std::free(dict);
    std::free(entries);
    std::free(accessesDict);
    std::free(accesses);
}

inline ulong ChainedAdaptive::_random() {
    ulong r = (ulong)random();
    r = r<<31;
    r = r + (ulong)random;
    return r;
}

inline ulong ChainedAdaptive::_murmurHash(ulong h) {
    h ^= h >> 33;
    h *= 0xff51afd7ed558ccd;
    h ^= h >> 33;
    h *= 0xc4ceb9fe1a85ec53;
    h ^= h >> 33;
    h = h >> (64 - hashpower);
    return h;
}

inline void ChainedAdaptive::_fetchDefault(HashmapReq *r) {
    ulong h = _murmurHash(r->key);
    KV* ptr = dict[h];
    while (ptr && ptr->key != r->key) {
        ptr = ptr->next;
    }
    if (ptr == NULL) return;
    r->value = ptr->value;
    numReqs += 1;
}

inline void ChainedAdaptive::_fetchBenchmark(HashmapReq *r) {
    ulong h = _murmurHash(r->key);
    KV* ptr = dict[h];
    while (ptr && ptr->key != r->key) {
        ptr = ptr->next;
    }
    if (ptr == NULL) return;
    r->value = ptr->value;
    numReqs += 1;
    // ulong h = _murmurHash(r->key);
    // KV* ptr = dict[h];
    // ulong disp = 0;
    // while (ptr && ptr->key != r->key) {
    //     disp += 1;
    //     ptr = ptr->next;
    // }
    // if (ptr == NULL) return;
    // r->value = ptr->value;
    // displacement += disp;
    // displacement_sq += disp*disp;
    // numReqs += 1;
}

inline void ChainedAdaptive::_fetchAdaptive(HashmapReq *r) {
    ulong h = _murmurHash(r->key);
    KV* ptr = dict[h];
    while (ptr && ptr->key != r->key) {
        ptr = ptr->next;
    }
    if (ptr == NULL) return;
    r->value = ptr->value;
    numReqs += 1;
    // ulong h = _murmurHash(r->key);
    // KV* ptr = dict[h];
    // KV* min_access_entry = ptr;
    // Acc* aptr = accessesDict[h];
    // Acc* min_access_ptr = aptr;
    // while (ptr && ptr->key != r->key) {
    //     if (aptr->accesses < min_access_ptr->accesses) {
    //         min_access_ptr = aptr;
    //         min_access_entry = ptr;
    //     }
    //     ptr = ptr->next;
    //     aptr = aptr->next;
    // }
    // if (ptr == NULL) return;
    // r->value = ptr->value;
    // numReqs += 1;
    // if (aptr->accesses > min_access_ptr->accesses) {
    //     // exchange
    //     ulong buf;
    //     uint8_t abuf;

    //     // key
    //     buf = ptr->key;
    //     ptr->key = min_access_entry->key;
    //     min_access_entry->key = buf;

    //     // value
    //     buf = ptr->value;
    //     ptr->value = min_access_entry->value;
    //     min_access_entry->value = buf;

    //     // accesses
    //     abuf = aptr->accesses;
    //     aptr->accesses = min_access_ptr->accesses;
    //     min_access_ptr->accesses = abuf;
    // }
}

inline void ChainedAdaptive::_insert(HashmapReq *r) {
    ulong h = _murmurHash(r->key);
    KV* ptr = dict[h];
    int steps = 0;
    while (ptr && ptr->key != r->key) {
        ptr = ptr->next;
        steps += 1;
    }
    if (ptr==NULL) {
        _setFinal(r->key, r->value);
        cardinality += 1;
        return;
    }
    // else
    ptr->value = r->value;
    numReqs += 1;
    if (mode == ADAPTIVE) {
        Acc* aptr = accessesDict[h];
        while (steps) {
            aptr = aptr->next;
            steps -= 1;
        }
        aptr->accesses += 1;
    }
}

inline void ChainedAdaptive::_delete(HashmapReq *r) {
    ulong h = _murmurHash(r->key);
    KV *prev, *cur;
    Acc *aprev, *acur; // corresponding pointers in the accesses hm
    cur = prev = dict[h];
    aprev = acur = accessesDict[h];
    while (cur != NULL && cur->key != r->key) {
        prev = cur;
        aprev = acur;
        cur = cur->next;
        acur = acur->next;
    }
    if (cur == NULL) return;
    if (prev != cur) {
        prev->next = cur->next;
        aprev->next = acur->next;
    } else {
        dict[h] = cur->next;
        accessesDict[h] = acur->next;
    }
    cardinality -= 1;
}

inline void ChainedAdaptive::_update(HashmapReq *r) {
    // skip for now    
}

inline void ChainedAdaptive::_setFinal(ulong key, ulong value) {
    entries[entriesOffset].key = key;
    entries[entriesOffset].value = value;
    ulong h = _murmurHash(key);
    entries[entriesOffset].next = dict[h];
    dict[h] = &entries[entriesOffset];
    accesses[entriesOffset+1].next = accessesDict[h];
    accessesDict[h] = &accesses[entriesOffset+1];
    entriesOffset += 1;
}

// Used only while rehashing, don't use elsewhere
// Inserts at the end of the chain, not at the start
inline void ChainedAdaptive::_setFinalEnd(ulong key, ulong value) {
    entries[entriesOffset].key = key;
    entries[entriesOffset].value = value;
    ulong h = _murmurHash(key);
    KV* ptr = dict[h];
    Acc* aptr = accessesDict[h];
    entries[entriesOffset].next = NULL;
    accesses[entriesOffset+1].next = NULL;
    if (ptr == NULL) {
        dict[h] = &entries[entriesOffset];
        accessesDict[h] = &accesses[entriesOffset+1];
    } else {
        while (ptr->next != NULL) {
            ptr = ptr->next;
            aptr = aptr->next;
        }
        ptr->next = &entries[entriesOffset];
        aptr->next = &accesses[entriesOffset+1];
    }
    entriesOffset += 1;
}

inline ulong ChainedAdaptive::_getTimeDiff(struct timespec startTime, struct timespec endTime) {
    return (ulong)((endTime.tv_sec - startTime.tv_sec)*1000000 +
        double(endTime.tv_nsec - startTime.tv_nsec)/1000);
}

inline int ChainedAdaptive::_getHashpower() {
    int hashpower = 0;
    while (pow(2, hashpower) < this->cardinality) {
        hashpower += 1;
    }
    return hashpower;
}

inline void ChainedAdaptive::_resetAccesses() {
    for (ulong i=0; i<=entriesOffset; i++) {
        accesses[i].accesses = 0;
    }
}
