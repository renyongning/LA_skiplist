#include <limits>
#include <omp.h>

// define some constants
# define LONG_PRIME 4294967311l
# define MIN(a,b)  (a < b ? a : b)

/** CountMinSketch class definition here **/
class CountMinSketch {
  // width, depth 
  unsigned int w,d;
  
  // eps (for error), 0.01 < eps < 1
  // the smaller the better
  float eps;
  
  // gamma (probability for accuracy), 0 < gamma < 1
  // the bigger the better
  float gamma;
  
  // aj, bj \in Z_p
  // both elements of fild Z_p used in generation of hash
  // function
  unsigned int aj, bj;

  // total count so far
  unsigned int total; 

  // array of arrays of counters
  std::vector<std::vector<int>> C;

  // array of hash values for a particular item 
  // contains two element arrays {aj,bj}
  std::vector<std::vector<int>> hashes;

  // generate "new" aj,bj
  void genajbj(std::vector<std::vector<int>>& hashes, int i);

public:
  // constructor
  CountMinSketch(float eps, float gamma);
  
  // update item (int) by count c
  void update(ulong item, int c);
 
  // estimate count of item i and return count
  unsigned int estimate(ulong item);

  // return total count
  unsigned int totalcount();

};

CountMinSketch::CountMinSketch(float ep, float gamm) {
  if (!(0.009 <= ep && ep < 1)) {
    std::cout << "eps must be in this range: [0.01, 1)" << std::endl;
    exit(EXIT_FAILURE);
  } else if (!(0 < gamm && gamm < 1)) {
    std::cout << "gamma must be in this range: (0,1)" << std::endl;
    exit(EXIT_FAILURE);
  }
  eps = ep;
  gamma = gamm;
  w = ceil(exp(1)/eps);
  d = ceil(log(1/gamma));
  total = 0;
  // initialize counter array of arrays, C
  C.resize(d, std::vector<int>(w,0));
  // initialize d pairwise independent hashes
  srand(time(NULL));
  hashes.resize(d, std::vector<int>(2));
  for (int i = 0; i < d; i++) {
    genajbj(hashes, i);
  }
}

// CountMinSketch totalcount returns the
// total count of all items in the sketch
unsigned int CountMinSketch::totalcount() {
  return total;
}

// countMinSketch update item count (int)
void CountMinSketch::update(ulong item, int c) {
  total += c;
  unsigned int hashval = 0;
  for (unsigned int j = 0; j < d; j++) {
    hashval = ((long)hashes[j][0]*item+hashes[j][1])%LONG_PRIME%w;
    C[j][hashval] += c;
  }
}

// CountMinSketch estimate item count (int)
unsigned int CountMinSketch::estimate(ulong item) {
  int minval = std::numeric_limits<int>::max();
  unsigned int hashval = 0;
  for (unsigned int j = 0; j < d; j++) {
    hashval = ((long)hashes[j][0]*item+hashes[j][1])%LONG_PRIME%w;
    minval = MIN(minval, C[j][hashval]);
  }
  return minval;
}

// generates aj,bj from field Z_p for use in hashing
void CountMinSketch::genajbj(std::vector<std::vector<int>>& hashes, int i) {
  hashes[i][0] = int(float(rand())*float(LONG_PRIME)/float(RAND_MAX) + 1);
  hashes[i][1] = int(float(rand())*float(LONG_PRIME)/float(RAND_MAX) + 1);
}
