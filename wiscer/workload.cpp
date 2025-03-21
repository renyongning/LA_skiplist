#include "workload.h"
/*
2024/8/7
提供了负载变化前后的频率信息,负载变化时机
*/

std::unordered_map<ulong, ulong> accessCounter; 

ulong totalAccess = 0;

std::vector<std::unordered_map<ulong, double>> probs;

std::vector<ulong> changeTimes;

ulong currentTime=0;

std::vector<std::vector<std::pair<ulong, double>>> sortedProbs;

Workload::Workload(float zipf,
    ulong initialSize,
    ulong operationCount,
    ulong distShiftFreq,
    float distShiftPrct,
    float fetchProportion,
    float insertProportion,
    float deleteProportion,
    string storageEngine
) {
    this->zipf = zipf;
    this->initialSize = initialSize;
    this->operationCount = operationCount;
    this->distShiftFreq = distShiftFreq;
    this->distShiftPrct = distShiftPrct/10;
    this->fetchProportion = fetchProportion;
    this->insertProportion = insertProportion;
    this->deleteProportion = deleteProportion;
    this->hm = new Hashmap();
}

Workload::Workload(string filename) {
    ifstream inputFile(filename);
    string line;
    char *token, *property, *val;
    if (!inputFile.is_open()) {
        cout << "Could not open file " << filename << endl;
        return;
    }
    this->workloadFile = filename;
    while (getline(inputFile, line)) {
        if (!line.length()) continue;
        property = strtok((char*)line.c_str(), "=");;
        val = strtok(NULL, "=");
        if (strcmp(property, "zipf") == 0) {
            this->zipf = stof(val);
        } else if (strcmp(property, "initialSize") == 0) {
            this->initialSize = (ulong)stoul(val);
        } else if (strcmp(property, "operationCount") == 0) {
            this->operationCount = (ulong)stoul(val);
        } else if (strcmp(property, "distShiftFreq") == 0) {
            this->distShiftFreq = (ulong)stoul(val);
        } else if (strcmp(property, "distShiftPrct") == 0) {
            this->distShiftPrct = stof(val)/float(100);
        } else if (strcmp(property, "fetchProportion") == 0) {
            this->fetchProportion = stof(val);
        } else if (strcmp(property, "insertProportion") == 0) {
            this->insertProportion = stof(val);
        } else if (strcmp(property, "deleteProportion") == 0) {
            this->deleteProportion = stof(val);
        } else if (strcmp(property, "keyPattern") == 0) {
            if (strcmp(val, "random") == 0) {
                //this->keyPattern = SEQUENTIAL;
                this->keyPattern = RANDOM;
            } else if (strcmp(val, "sequential") == 0) {
                this->keyPattern = SEQUENTIAL;
            } else {
                this->keyPattern = RANDOM;
            }
        } else if (strcmp(property, "keyorder") == 0) {
            if (strcmp(val, "random") == 0) {
                this->keyorder = RANDOM;
            } else if (strcmp(val, "sorted") == 0) {
                this->keyorder = SORTED;
            } else {
                this->keyorder = RANDOM;
            }
        } else if (strcmp(property, "outputFile") == 0) {
            this->outputFile = val;
        }
    }
    this->hm = new Hashmap();
}

void Workload::setRandomSeed(uint seed) {
    srand(seed);
}

void Workload::printParams() {
    cout << "zipf: " << this->zipf << endl;
    cout << "initialSize: " << this->initialSize << endl;
    cout << "operationCount: " << this->operationCount << endl;
    cout << "distShiftFreq: " << this->distShiftFreq << endl;
    cout << "distShiftPrct: " << this->distShiftPrct << endl;
    cout << "fetchProportion: " << this->fetchProportion << endl;
    cout << "insertProportion: " << this->insertProportion << endl;
    cout << "deleteProportion: " << this->deleteProportion << endl;
}

void Workload::run() {
    initHashmap();
    // Run
    HashmapReq *reqs = (HashmapReq*)malloc(sizeof(HashmapReq)*this->operationCount);
    if (!reqs) {
        cout << "Malloc failed while initializing workload, insufficient memory" << endl;
        exit(1);
    }
    memset(reqs, 0, sizeof(HashmapReq)*this->operationCount);
    ulong numBatches = this->operationCount/this->batchSize;
    if (this->operationCount % this->batchSize > 0) {
        numBatches += 1;
    }
    this->throughput = (ulong*)malloc(sizeof(ulong)*numBatches);
    this->retdInsts = (ulong*)malloc(sizeof(ulong)*numBatches);
    this->l3Misses = (ulong*)malloc(sizeof(ulong)*numBatches);
    this->l2Misses = (ulong*)malloc(sizeof(ulong)*numBatches);
    this->l1Misses = (ulong*)malloc(sizeof(ulong)*numBatches);
    this->displacement = (ulong*)malloc(sizeof(ulong)*numBatches);
    memset(this->throughput, 0, sizeof(ulong)*numBatches);
    float fetchSlab = this->fetchProportion*100;
    float deleteSlab = (this->fetchProportion + this->deleteProportion)*100;
    float insertSlab = (this->fetchProportion + this->deleteProportion +
        this->insertProportion)*100;
    if (insertSlab != 100) {
        cout << "Invalid request proportions" << endl;
        exit(1);
    }
    ulong r;
    Metrics m;
    ulong totalTime = 0;
    /* First generate the operations */
    for (ulong i = 0; i<this->operationCount; i++) {
        r = random() % 100;
        if (r < fetchSlab) {
            // req_type = FETCH_REQ;
            this->_genFetchReq(reqs, i);
        } else if (r < deleteSlab && r >= fetchSlab) {
            // req_type = DELETE_REQ;
            this->_genDeleteReq(reqs, i);
        } else if (r < insertSlab && r >= deleteSlab) {
            // req_type = INSERT_REQ;
            this->_genInsertReq(reqs, i);
        }
        requestsIssued += 1;
        if (requestsIssued % distShiftFreq == 0) {
            this->_shiftDist();
            std::unordered_map<ulong, double> currentProbs;
            for (const auto& pair : accessCounter) {
                currentProbs[pair.first] = static_cast<double>(pair.second) / totalAccess;
            }
            probs.push_back(currentProbs);
            changeTimes.push_back(currentTime);
            currentTime+=distShiftFreq;
            accessCounter.clear();
            totalAccess = 0;
        }        
    }
    // 检查是否有未统计的请求
    if (totalAccess > 0) {
        std::unordered_map<ulong, double> currentProbs;
        for (const auto& pair : accessCounter) {
            currentProbs[pair.first] = static_cast<double>(pair.second) / totalAccess;
        }
        probs.push_back(currentProbs);
        changeTimes.push_back(currentTime);
        storeRequestsToFile(reqs);
        storeKeyFrequenciesToFile();
    }
    //排序后的键
    for (const auto& phaseProbs : probs) {
        std::vector<std::pair<ulong, double>> sortedPhaseProbs(phaseProbs.begin(), phaseProbs.end());
        
        std::sort(sortedPhaseProbs.begin(), sortedPhaseProbs.end(), [](const std::pair<ulong, double>& a, const std::pair<ulong, double>& b) {
            return a.second > b.second; // 按照概率值从大到小排序
        });

        sortedProbs.push_back(sortedPhaseProbs);
    }
    // 输出结果以验证
    /*for (size_t i = 0; i < sortedProbs.size(); ++i) {
        std::cout << "Phase " << i << ":\n";
        for (const auto& pair : sortedProbs[i]) {
            std::cout << "Key: " << pair.first << ", Probability: " << pair.second << "\n";
        }
    }*/
    //为了使用统计的准确频率，将bulkload从inithashmap函数中放到后面
    //将popOrder（可能被更改过）改为原始的originOrder
    hm->bulkLoad(originOrder, initialSize);
    for (ulong i=0; i<numBatches; i++) {
        ulong batchSize = this->batchSize;
        if (i == numBatches - 1 && (this->operationCount % this->batchSize) > 0) {
            batchSize = this->operationCount % this->batchSize;
        }
        m = hm->processRequests(&reqs[i*(this->batchSize)], batchSize); // us
        //std::cout<<"success batch "<< i <<std::endl;
        throughput[i] = (1000000*batchSize)/m.timeElapsedus;
        retdInsts[i] = m.retiredInst;
        l3Misses[i] = m.l3Miss;
        l2Misses[i] = m.l2Miss;
        l1Misses[i] = m.l1Miss;
        displacement[i] = m.displacement;
        totalTime += m.timeElapsedus;
        hm->rehash(); // Do rehashing if necessary
    }

    // hm->show();
    cout << "Total time (us): " << totalTime << endl;
    cout << "Net throughput: " << this->operationCount/float(totalTime) << " Mops/s" << endl;
    storeOutput();
    std::free(reqs);
    this->free();
}

inline void Workload::initHashmap() {
    int hashpower = 0;
    while (pow(2, hashpower) < this->initialSize) {
        hashpower += 1;
    }

    hm->initHashpower(hashpower);
    this->_choosePrime();

    ulong finalSize = this->initialSize + this->insertProportion*operationCount + 1;

    popOrder = (ulong*)malloc(sizeof(ulong)*finalSize);
    originOrder = (ulong*)malloc(sizeof(ulong)*finalSize);

    cumProb = (double*)malloc(sizeof(double)*finalSize);
    memset(cumProb, 0, sizeof(double)*finalSize);
    memset(popOrder, 0, sizeof(ulong)*finalSize);

    if (this->keyPattern == RANDOM) {
        std::cout<<"random"<<std::endl;
        popOrder[0] = this->_multAddHash(0);
        cumProb[0] = 1/pow(1, this->zipf);
        cumsum = cumProb[0];
        for (ulong i=1; i<initialSize; i++) {
            /* Mult Add hash function, for generating random ulong numbers */
            popOrder[i] = this->_multAddHash(i);
            cumProb[i] = 1/pow(i+1, this->zipf);
            cumsum += cumProb[i];
            cumProb[i] += cumProb[i-1];
        }
    } else { // SEQUENTIAL
        popOrder[0] = 0;
        cumProb[0] = 1/pow(1, this->zipf);
        cumsum = cumProb[0];
        for (ulong i=1; i<initialSize; i++) {
            popOrder[i] = i;
            cumProb[i] = 1/pow(i+1, this->zipf);
            cumsum += cumProb[i];
            cumProb[i] += cumProb[i-1];
        }
        // The popularity order of keys is arbitrary
        this->_random_shuffle(popOrder, initialSize);
    }
    //for (ulong i=0; i<initialSize; i++) {originOrder[i]=popOrder[i];std::cout<<originOrder[i]<<" ";}
    std::cout<<std::endl;
    //归一化过程后进行
    //为了使用统计的准确频率，将bulkload从inithashmap函数中放到后面
    //hm->bulkLoad(popOrder, initialSize);
    this->cardinality = initialSize;
    this->maxInsertedIdx = initialSize-1;
    if (this->keyorder == RANDOM) {
        this->_random_shuffle(popOrder, initialSize);
    } else if (this->keyorder == SORTED) {
        // key inserted at the end is in the most favorable spot
        this->_reverse(popOrder, initialSize);
    }

    for (ulong i=0; i<initialSize; i++)
    {
        originOrder[i]=popOrder[i];
        //std::cout<<originOrder[i]<<" ";
    }
}

void Workload::storeOutput() {
    ofstream output(this->outputFile);
    ulong numBatches = this->operationCount/this->batchSize;
    if (this->operationCount % this->batchSize > 0) {
        numBatches += 1;
    }
    output << "Throughput | "
        << "Retd. Instructions | "
        << "L3 Misses | "
        << "L2 Misses | "
        << "L1 Misses | "
        << "Displacement" << endl;
    for (ulong i=0; i<numBatches; i++) {
        output << throughput[i] << " " 
            << retdInsts[i] << " "
            << l3Misses[i] << " "
            << l2Misses[i] << " "
            << l1Misses[i] << " "
            << displacement[i]
            << endl;
    }
    output.close();
}

inline void Workload::_genFetchReq(HashmapReq *reqs, ulong i) {
    ulong r = this->_random();
    ulong max = 4611686018427387903L;
    double slab = double(r)/double(max);
    slab = slab*this->cumsum;
    ulong low = 0;
    ulong high = this->cardinality;
    ulong mid;

    while ((high - low) > 1){
        // cout << "high: " << high << ", low: " << low << ", mid: " << mid << endl;
        if (slab < cumProb[0]) {
            high = 0;
            break;
        } else if (slab > cumProb[this->cardinality-1]) {
            r = this->_random();
            slab = double(r)/double(max);
            slab = slab*this->cumsum;
            continue;
        }
        mid = (low + high)/2;
        if (this->cumProb[mid] > slab) {
            high = mid;
        } else if (this->cumProb[mid] <= slab) {
            low = mid;
        }
    }
    // Set req params
    reqs[i].key = this->popOrder[high];
    reqs[i].value = this->_random();
    reqs[i].reqType = FETCH_REQ;
    totalAccess += 1;
    accessCounter[reqs[i].key] += 1;
}

inline void Workload::_genInsertReq(HashmapReq *reqs, ulong i) {
    ulong n = _multAddHash(this->maxInsertedIdx + 1);
    this->maxInsertedIdx += 1;

    // set the request
    reqs[i].key = n;
    reqs[i].value = _random();
    reqs[i].reqType = INSERT_REQ;
    
    ulong p = this->cardinality-1;
    ulong buf;
    // while (cumProb[p]/cumsum < 0.9) {
    //     buf = this->popOrder[p];
    //     this->popOrder[p] = n;
    //     n = buf;
    //     p = this->_random() % (this->cardinality - 1 - p) + p + 1;
    // }
    // For the last 10% keys, it doesn't matter. Just insert at the end.
    this->popOrder[this->cardinality] = n;

    // set state tracking params
    this->cardinality += 1;
    if (this->cumProb[this->cardinality-1] == 0) {
        this->cumProb[this->cardinality-1] = 1/pow(this->cardinality, zipf);
        this->cumProb[this->cardinality-1] += this->cumProb[this->cardinality-2];
    }
    this->cumsum += this->cumProb[this->cardinality-1] - this->cumProb[this->cardinality-2];
}

inline void Workload::_genDeleteReq(HashmapReq *reqs, ulong i) {
    ulong p = this->_random() % this->cardinality;
    ulong p_old, buf;

    // set the request, popOrder[p] has the key to be deleted
    reqs[i].key = popOrder[p];
    reqs[i].value = 0;
    reqs[i].reqType = DELETE_REQ;

    // bubble down
    while (cumProb[p]/cumsum < 0.9) {
        p_old = p;
        buf = popOrder[p];
        p = this->_random() % (this->cardinality - p - 1) + p + 1;
        this->popOrder[p_old] = this->popOrder[p];
        this->popOrder[p] = buf;
    }

    // For the last 10% prob, just exchange with the last element
    popOrder[p] = popOrder[this->cardinality-1];

    // set state tracking params
    cumsum -= (cumProb[this->cardinality-1] - cumProb[this->cardinality-2]);
    this->cardinality -= 1;
}

inline void Workload::_shiftDist() {
    if (this->distShiftPrct == 0) return;
    ulong p = -1;
    ulong pnew, buf;
    do {
        p += 1;
        pnew = this->_random() % (this->cardinality - p - 1) + p + 1;
        buf = this->popOrder[p];
        popOrder[p] = popOrder[pnew];
        popOrder[pnew] = buf;
    } while (this->cumProb[p]/this->cumsum < this->distShiftPrct);
}

void Workload::free() {
    this->zipf = 1;
    this->initialSize = 0;
    this->operationCount = 0;
    this->distShiftFreq = 0;
    this->distShiftPrct = 0;
    this->fetchProportion = 1;
    this->insertProportion = 0;
    this->deleteProportion = 0;
    std::free((void*)this->popOrder);
    std::free((void*)this->cumProb);
    std::free((void*)this->throughput);
    std::free((void*)this->retdInsts);
    std::free((void*)this->l3Misses);
    std::free((void*)this->l2Misses);
    std::free((void*)this->l1Misses);
    std::free((void*)this->displacement);
    hm->free();
}

inline ulong Workload::_multAddHash(ulong i) {
    return i*this->chosenPrime[0] + this->chosenPrime[1];;
}

void Workload::_choosePrime() {
    // srand(0);
    ulong primes[10] = {7761362401859887,
        5937911637806579,
        4062741855079417,
        6757727681041201,
        1767830588689157,
        6029750347057651,
        9370386929117087,
        5158899522772007,
        6846396768799417,
        6411045436602071};
    int i = random() % 10;
    this->chosenPrime[0] = primes[i];

    do {
        i = random() % 10;
        this->chosenPrime[1] = primes[i];
    } while (this->chosenPrime[0] == this->chosenPrime[1]);
}

inline ulong Workload::_random() {
    ulong r = (ulong)random();
    r = r<<31;
    r = r + (ulong)random();
    return r;
}

void Workload::_random_shuffle(ulong *array, ulong len) {
    ulong pos;
    ulong swap;
    for (int j=0; j<3; j++) {
        for (ulong i=len-1; i>0; i--) {
            pos = this->_random()%(i+1);
            swap = array[i];
            array[i] = array[pos];
            array[pos] = swap;
        }
    }
}

void Workload::_reverse(ulong *array, ulong len) {
    ulong start = 0;
    ulong end = len - 1;
    ulong buf;
    while (start < end) {
        buf = array[start];
        array[start] = array[end];
        array[end] = buf;
        start += 1;
        end -= 1;
    }
}

void Workload::storeKeyFrequenciesToFile() {
    // Open the file for writing, overwriting if it doesn't exist
    ofstream output("../outputs/keys.csv", ios::trunc); // Open the file in append mode
    cout << "storeKeyFrequenciesToFile" << endl;
    if (!output.is_open()) {
        cout << "Failed to open output file." << endl;
        return;
    }

    // If it's the first time writing, add the header
    if (output.tellp() == 0) {
        output << "Key,Frequency\n";  // Write the header
    }

    // For each key, write its frequency to the file
    for (const auto& pair : accessCounter) {
        output << pair.first << "," << static_cast<double>(pair.second) / totalAccess << "\n";
    }

    output.close();
}
void Workload::storeRequestsToFile(HashmapReq* reqs) {
    // Open the file to write, overwriting if it doesn't exist
    ofstream output("../outputs/reqs.txt", ios::trunc); // Open the file in append mode
    if (!output.is_open()) {
        cout << "Failed to open output file." << endl;
        return;
    }

    // Write all the FETCH requests' keys to the file
    for (ulong i = 0; i < this->operationCount; i++) {
        if (reqs[i].reqType == FETCH_REQ) {
            output << reqs[i].key << " ";  // Write the key followed by a space
        }
    }

    // End the line after writing all keys for this batch
    output << "\n";  // Newline after writing all keys in this batch

    output.close();
}
