#include "primes.hpp"


// A prime sieve based on the sieve of eratosthenes.
// Very similar to the ruby implementation in problem-35.rb
std::set<int> Primes::upto (int lim) {
  std::set<int> primes;
  std::vector<int> sieve;
  // Build the unmasked sieve
  for (int i=1; i<=lim; i++) sieve.push_back(i);
  // Sieve it. We'll use 0 as the nullification marker
  for (int i=2; i<=lim; i++) {
    int si = i-1;
    int s = sieve[si];
    // Check for pre-existing nullification
    if(s != 0)  {
      // Poosh.
      primes.insert(s);
      // Nullify multiples
      for(int m = s+s; m<=lim; m+=s) sieve[m-1] = 0;  
    }
  }
  return primes;
}