/*
  The number, 197, is called a circular prime because all rotations of the 
  digits: 197, 971, and 719, are themselves prime.
  
  There are thirteen such primes below 100: 2, 3, 5, 7, 11, 13, 17, 31, 37, 
  71, 73, 79, and 97.
  
  How many circular primes are there below one million?
*/
/*
  Thinking out loud:

  Alright, I'm wanting a more performance and some more learning,
  so I'm switching to C++. Let's see where this takes us...
*/

#include <iostream>
#include <set>
#include <sstream>
#include <algorithm>
#include "cpplib/primes.hpp"

using namespace std;

int main() {
  // Use the sieve to generate the primes
  set<int> primes = Primes::upto(1000000);
  set<int> circularPrimes;

  // Now iterate and test for rotation
  for(set<int>::iterator i=primes.begin(); i!=primes.end(); i++) {
    int p = *i;
    string ps = static_cast<ostringstream*>( &(ostringstream() << p) )->str();
    
    bool circular = true;
    for(unsigned int j=0; j<ps.size()-1; j++) {
      // Rotate string
      rotate(ps.begin(), ps.begin() + 1, ps.end());
      // Cast back to int
      int ri = atoi(ps.c_str());
      // Find...
      if(primes.find(ri) == primes.end()) circular = false;
    }
    if(circular) circularPrimes.insert(p);
  }

  cout << primes.size() << " primes" << endl;
  cout << circularPrimes.size() << " circular primes" << endl;
  return 0;
}