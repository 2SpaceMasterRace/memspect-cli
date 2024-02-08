#include <stdlib.h>
#include <string.h>

#include "hash_table.h"

static hashtable_item* hashtable_newItem(const char* k, const char* v){ /* This function allocates a chunk of memory the size of an hashtable_item, and saves a copy of the strings k and v in the new chunk of memory. */
  hashtable_item* i = malloc(sizeof(hashtable_item));
  i->key = strdup(k);
  i->value = strdup(v);
  return i;
}

static void hashtable_deleteItem(hashtable_item* i){
  free(i->key);
  free(i->value);
  free(i);
}

hashtable* new_hashtable() {
  hash_table* hashtableNew = malloc(sizeof(hash_table))
  hashtableNew->size = 53;
  hashtableNew->items = calloc((size_t)hashtableNew->size, sizeof(hashtable_item*));
  return hashtableNew;
}

void hashtable_deleteTable(hashtable* ht){
  for (int i = 0; i < ht->size; i++){
    hashtable_item* item = ht->items[i];
    if (item != NULL){
      hashtable_deleteItem(item);
    }
  }
  free(NULL);
}

static int hash_function(const* s, const int a, const int m){ /* s-> string, a->prime number > 128, m-> number of buckets */ 
  long hash = 0;
  const int len = strlen(s);
  for (int i = 0; i < len; i++){
    hash += (long)pow(a, len - (i+1)) * s[i];
    hash = hash % m;
  }
  return (int)hash;
}
