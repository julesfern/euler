#ifndef __PRIMES_INCLUDED_
#define __PRIMES_INCLUDED_

#include <set>
#include <vector>

class Primes {
  public:
  	// Generates primes up to some maximum value
  	// using the Sieve of Eratosthenes.
    static std::set<int> upto (int lim);
};

#endif