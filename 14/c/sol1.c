#include "stdio.h"
#include "stdlib.h"

// Global state
unsigned long int quantities[26];

int pairs_idx = 0;
unsigned long int pairs[26][26][2];

struct Rule {
  int first;
  int second;
  int insert;
} typedef Rule;

int rules_len = 0;
Rule rules[100];

// Run rules for one step
void apply_rule (Rule *rule) {
  unsigned long int *count = &pairs[rule->first][rule->second][pairs_idx];
  if (*count == 0) return;

  pairs[rule->first][rule->insert][!pairs_idx] += *count;
  pairs[rule->insert][rule->second][!pairs_idx] += *count;
  quantities[rule->insert] += *count;
  *count = 0;
}

void step () {
  for (int ii = 0; ii < rules_len; ii++) apply_rule(&rules[ii]);
  pairs_idx = !pairs_idx;
}

// Read inputs
void load_inputs () {
  char prev = 0;
  char inp = getc(stdin);

  while (inp != '\n') {
    quantities[inp - 65]++;
    if (prev != 0) pairs[prev - 65][inp - 65][0]++;
    prev = inp;
    inp = getc(stdin);
  }

  getc(stdin);

  char first, second, insert;
  while (scanf("%c%c -> %c\n", &first, &second, &insert) == 3) {
    rules[rules_len].first = first - 65;
    rules[rules_len].second = second - 65;
    rules[rules_len].insert = insert - 65;
    rules_len++;
  }
}

int main () {
  // Load inputs, run 10 steps
  load_inputs();
  for (int ii = 0; ii < 10; ii++) step();

  // Calculate min, max
  long int min, max = 0;
  for (int ii = 0; ii < 26; ii++) {
    if (quantities[ii] == 0) continue;
    if (min == 0 || min > quantities[ii]) min = quantities[ii];
    if (max < quantities[ii]) max = quantities[ii];
  }

  printf("Min %ld, Max %ld, Difference %ld\n", min, max, max - min);
}
