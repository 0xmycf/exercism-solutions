#include "scrabble_score.h"
#include <string.h>
#include <ctype.h>

/*
    Letter                           Value
    A, E, I, O, U, L, N, R, S, T       1
    D, G                               2
    B, C, M, P                         3
    F, H, V, W, Y                      4
    K                                  5
    J, X                               8
    Q, Z                               10
*/

unsigned int score_number(const char letter) {

  char ones[] = {'A', 'E', 'I', 'O', 'U', 'L', 'N', 'R', 'S', 'T', '\0'};
  char twos[] = {'D', 'G', '\0'};
  char threes[] = {'B', 'C', 'M', 'P', '\0'};
  char fours[] = {'F', 'H', 'V', 'W', 'Y', '\0'};
  char fives[] = {'K', '\0' };
  char eights[] = {'J', 'X', '\0'};
  char tens[] = {'Q', 'Z', '\0'};
  if (strchr(ones, letter) != 0) {
    return 1;
  } else if (strchr(twos, letter) != 0) {
    return 2;
  } else if (strchr(threes, letter) != 0) {
    return 3;
  } else if (strchr(fours, letter) != 0) {
    return 4;
  } else if (strchr(fives, letter) != 0) {
    return 5;
  } else if (strchr(eights, letter) != 0) {
    return 8;
  } else if (strchr(tens, letter) != 0) {
    return 10;
  }
  return 1000000000;
}

unsigned int score(const char *word) {
  int sum = 0;
  for (int i = 0; word[i] != 0; i++) {
    unsigned char letter = toupper((unsigned char) word[i]);
    sum += score_number(letter);
  }
  return sum;
}

