#include <string.h>
#include <stdio.h>
#include <stdlib.h>

struct Hole {
  int x;
  int y;
} typedef Hole;

struct LL {
  void* data;
  struct LL* next;
} typedef LL;

void push (LL** next, void* data) {
  LL* head = malloc(sizeof(LL));
  head->data = data;
  head->next = *next;
  *next = head;
}

int main () {
  LL* holes = NULL;

  Hole* hole = malloc(sizeof(Hole));
  while (scanf("%d,%d\n", &hole->x, &hole->y) == 2) {
    push(&holes, hole);
    hole = malloc(sizeof(Hole));
  }

  char dim;
  int pos;
  while (scanf("fold along %c=%d\n", &dim, &pos) == 2) {
    LL* head = holes;
    while (head != NULL) {
      hole = (Hole*) head->data;
      switch (dim) {
        case 'x':
          if (hole->x > pos) hole->x = 2 * pos - hole->x;
          break;
        case 'y':
          if (hole->y > pos) hole->y = 2 * pos - hole->y;
          break;
      }
      head = head->next;
    }
  }

  int max_width = 0;
  int max_height = 0;

  LL* head = holes;
  while (head != NULL) {
    hole = (Hole*) head->data;
    if (max_width < hole->x) max_width = hole->x;
    if (max_height < hole->y) max_height = hole->y;
    head = head->next;
  }

  max_width++;
  max_height++;

  char* out = calloc(max_height * (max_width + 1) + 1, sizeof(char));
  memset(out, ' ', max_height * (max_width + 1));

  head = holes;
  while (head != NULL) {
    hole = (Hole*) head->data;
    out[hole->x + hole->y * (max_width + 1)] = '#';
    head = head->next;
  }

  for (int y = 1; y <= max_height; y++) {
    out[y * (max_width + 1) - 1] = '\n';
  }

  printf("%s\n", out);
}
