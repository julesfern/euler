/*

  The decimal number, 585 = 10010010012 (binary), is palindromic in both bases.
  Find the sum of all numbers, less than one million, which are palindromic in base 10 and base 2.
  (Please note that the palindromic number, in either base, may not include leading zeros.)

*/
/*
  Thinking out loud:

  Seems simple enough. Basic runtime checking every number was 1.3 seconds.

  But since we're not including leading zeroes, the first number in the binary
  representation will always be a 1. Which means the last number must be a 1.
  Which means all the b10 and b2 palindromes will be odd.

  That knocks down to 0.7 seconds.
*/

#import <iostream>
#import <sstream>
#import <algorithm>

using namespace std;

string intToBinaryString(int number) {
  ostringstream ss;
  int remainder;
  if(number <= 1) {
    ss << number;
  }
  else {
    remainder = number%2;
    ss << intToBinaryString(number >> 1) << remainder;  
  } 
  return (&ss)->str();
}

bool palindromic(string candidate) {
  //ostringstream ss;
  string::reverse_iterator r = candidate.rbegin(); 
  string::iterator i = candidate.begin();
  while(i!=candidate.end()) {
    if(*i != *r) return false;
    i++; r++;
  }
  return true;
}

int main() {
  int lim = 1000000;
  int count = 0;
  int sum = 0;
  for(int i = 1; i < lim; i+=2) {
    // Determine base 10 palindrome
    string b10 = static_cast<ostringstream*>( &(ostringstream() << i) )->str();
    if(palindromic(b10) && palindromic(intToBinaryString(i))) {
      sum += i; count++;
    }
  }
  cout << sum << " sum of " << count << " palindromic numbers in b10 and b2" << endl;
  return 0;
}