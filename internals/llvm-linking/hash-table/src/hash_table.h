typedef struct{
	char* key;
	char* value;
} hashtable_item; /* key-value items are stored here */

typedef struct{
	int size;
	int count;
	hashtable_item** items;
} hashtable; /* Hash Table stores:
		[x] array of pointers -> items
		[x] size of hash table
		[x] count of hash table (how full it is) */ 
