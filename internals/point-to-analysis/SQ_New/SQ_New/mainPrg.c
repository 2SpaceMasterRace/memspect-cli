
#include <string.h>
#include <stdio.h>
#include "mainPrg.h"

int MemoryLeak1()
{
	FRAMEP_SQ localFrm = NULL;
	long valueX = 2;
	
	printf("\n\n\n\t MemoryLeak1 Entry : Total Allocated Bytes = %lu \n", totalBytes_SQ);
	if (!(localFrm = CreateFrame_SQ()))
		return 0;
	
	SetFrmName_SQ(localFrm, "amFr");
	SetFrmType_SQ(localFrm, TLONG_SQ);
	SetFrmVal_SQ(localFrm, *(long *)&valueX);
	
	printf("\n\n\t MemoryLeak1 Exit : Total Allocated Bytes = %lu \n", totalBytes_SQ);
		
	// Memory allocated through CreateFrm is not de-allocated 
	return 1;
}

int MemoryLeak1_overflow()
{
	FRAMEP_SQ localFrm = NULL;
	long valueX = 2;
	char testing[4] = "\0";
	
	printf("\n\n\n\t MemoryLeak1 overflow Entry : Total Allocated Bytes = %lu \n", totalBytes_SQ);
	if (!(localFrm = CreateFrame_SQ()))
		return 0;
	
	SetFrmName_SQ(localFrm, "amFr");
	SetFrmType_SQ(localFrm, TLONG_SQ);
	SetFrmVal_SQ(localFrm, *(long *)&valueX);
	
	printf("\n\n\t MemoryLeak1 overflow Exit : Total Allocated Bytes = %lu \n", totalBytes_SQ);
		
	strcpy(testing, "abcdefg"); /* array overflow */
	// Memory allocated through CreateFrm is not de-allocated 
	return 1;
}

int NoMemoryLeak1()
{
	static FRAMEP_SQ localFrm = NULL;
	long valueX = 2;
	
	printf("\n\n\n\t NoMemoryLeak1 Entry : Total Allocated Bytes = %lu \n", totalBytes_SQ);
	if (localFrm == NULL)
	{
		if (!(localFrm = CreateFrame_SQ()))
			return 0;
	}
	
	SetFrmName_SQ(localFrm, "amFr");
	SetFrmType_SQ(localFrm, TLONG_SQ);
	SetFrmVal_SQ(localFrm, *(long *)&valueX);
		
	printf("\n\n\t NoMemoryLeak1 Exit : Total Allocated Bytes = %lu \n", totalBytes_SQ);
	// No memory leak as localFrm is static 
	return 1;
}

int NoMemoryLeak2()
{
	FRAMEP_SQ localFrm = NULL;
	long valueX = 2;
	
	printf("\n\n\n\t NoMemoryLeak2 Entry : Total Allocated Bytes = %lu \n", totalBytes_SQ);
	if (localFrm == NULL)
	{
		if (!(localFrm = CreateFrame_SQ()))
			return 0;
	}
	
	SetFrmName_SQ(localFrm, "amFr");
	SetFrmType_SQ(localFrm, TLONG_SQ);
	SetFrmVal_SQ(localFrm, *(long *)&valueX);
		
	DeleteFrame_SQ(localFrm);
	printf("\n\n\t NoMemoryLeak2 Exit : Total Allocated Bytes = %lu \n", totalBytes_SQ);
	// No memory leak as localFrm is de-allocated  
	return 1;
}


int MemoryLeak2()
{
	static FRAMEP_SQ localFrm = NULL;
	long valueX = 2;
	
	printf("\n\n\n\t MemoryLeak2 Entry : Total Allocated Bytes = %lu \n", totalBytes_SQ);
	if (localFrm == NULL)
	{
		if (!(localFrm = CreateFrame_SQ()))
			return 0;
	}
	
	SetFrmName_SQ(localFrm, "amFr");
	SetFrmType_SQ(localFrm, TLONG_SQ);
	SetFrmVal_SQ(localFrm, *(long *)&valueX);
		
	localFrm = CreateFrame_SQ(); // Memory leak as localFrm is overwritten 
		
	printf("\n\n\n\t MemoryLeak2 Exit : Total Allocated Bytes = %lu \n", totalBytes_SQ);
	return 1;
}

int MemoryLeak2_overflow()
{
	static FRAMEP_SQ localFrm = NULL;
	long valueX = 2;
	char testing[4] = "\0";
	
	printf("\n\n\n\t MemoryLeak2 overflow Entry : Total Allocated Bytes = %lu \n", totalBytes_SQ);
	if (localFrm == NULL)
	{
		if (!(localFrm = CreateFrame_SQ()))
			return 0;
	}
	
	SetFrmName_SQ(localFrm, "amFr");
	SetFrmType_SQ(localFrm, TLONG_SQ);
	SetFrmVal_SQ(localFrm, *(long *)&valueX);
		
	localFrm = CreateFrame_SQ(); // Memory leak as localFrm is overwritten 
		
	printf("\n\n\n\t MemoryLeak2 overflow Exit : Total Allocated Bytes = %lu \n", totalBytes_SQ);
	strcpy(testing, "abcdefg"); /* array overflow */
	return 1;
}

int MemoryLeak3()
{
	static FRAMEP_SQ localFrm = NULL, localDAF = NULL;
	
	printf("\n\n\n\t MemoryLeak3 Entry : Total Allocated Bytes = %lu \n", totalBytes_SQ);
	if (localFrm == NULL)
	{
		if (!(localFrm = CreateFrame_SQ()))
			return 0;
	}
	
	if (localDAF == NULL)
	{
		localDAF = CreateDAF_SQ(localDAF, 0);
		if (localDAF == NULL)
		{
			// Memory leak as localFrm is not de-allocated 
			return 0;
		}
	}
	
	SetFrmName_SQ(localDAF, "amdf");
		
	localFrm = (FRAMEP_SQ)AppendElement_SQ(localDAF, NULL); // Memory leak as localFrm is overwritten 
		
	printf("\n\n\t MemoryLeak3 Exit : Total Allocated Bytes = %lu \n", totalBytes_SQ);
	return 1;
}

int MemoryLeak4()
{
	FRAMEP_SQ localDAF = NULL;
	
	printf("\n\n\n\t MemoryLeak4 Entry : Total Allocated Bytes = %lu \n", totalBytes_SQ);
	if (localDAF == NULL)
	{
		localDAF = CreateDAF_SQ(localDAF, 0);
		if (localDAF == NULL)
		{
			return 0;
		}
	}
	
	SetFrmName_SQ(localDAF, "amdf");
		
	// Memory leak as localDAF is not de-allocated  
	printf("\n\n\t MemoryLeak4 Exit : Total Allocated Bytes = %lu \n", totalBytes_SQ);
	return 1;
}

int NoMemoryLeak3()
{
	static FRAMEP_SQ localDAF = NULL;
	
	printf("\n\n\n\t NoMemoryLeak3 Entry : Total Allocated Bytes = %lu \n", totalBytes_SQ);
	if (localDAF == NULL)
	{
		localDAF = CreateDAF_SQ(localDAF, 0);
		if (localDAF == NULL)
		{
			return 0;
		}
	}
	
	SetFrmName_SQ(localDAF, "amdf");
		
	// No Memory leak as localDAF is static 
	printf("\n\n\t NoMemoryLeak3 Exit : Total Allocated Bytes = %lu \n", totalBytes_SQ);
	return 1;
}

int NoMemoryLeak4()
{
	FRAMEP_SQ localDAF = NULL;
	
	printf("\n\n\n\t NoMemoryLeak4 Entry : Total Allocated Bytes = %lu \n", totalBytes_SQ);
	if (localDAF == NULL)
	{
		localDAF = CreateDAF_SQ(localDAF, 0);
		if (localDAF == NULL)
		{
			// Memory leak as localFrm is not de-allocated 
			return 0;
		}
	}
	
	SetFrmName_SQ(localDAF, "amdf");
		
	DeleteFrame_SQ(localDAF);
	// No Memory leak as localDAF is de-allocated  
	printf("\n\n\t NoMemoryLeak4 Exit : Total Allocated Bytes = %lu \n", totalBytes_SQ);
	return 1;
}

FRAMEP_SQ FunctionLevel3()
{
	return CreateFrame_SQ();
}

FRAMEP_SQ FunctionLevel2()
{
	FRAMEP_SQ tmpFrmL2 = NULL;
	long value = 0; 
	
	tmpFrmL2 = CreateFrame_SQ();
	if (tmpFrmL2 == NULL)
	{
		tmpFrmL2 = FunctionLevel3();
		value = GetFrmVal_SQ(tmpFrmL2);
		printf ("Value of the frame created is : %d", value);
		return tmpFrmL2;
	}
	else
	{
		SetFrmName_SQ(tmpFrmL2, "here");
		SetFrmType_SQ(tmpFrmL2, TLONG_SQ);
		SetFrmVal_SQ(tmpFrmL2, 20);
		return tmpFrmL2;
	}
}

FRAMEP_SQ FunctionLevel1()
{
	int randomNum = 0;
	long value = 0;
	FRAMEP_SQ tmpFrm = NULL;
	
	randomNum = rand();
	
	if (randomNum > 250)
	{
		return FunctionLevel2();
	}
	else
	{
		tmpFrm = FunctionLevel2();
		if (tmpFrm)
		{
			value = GetFrmVal_SQ(tmpFrm);
			printf ("Value of the frame created is : %d", value);
			return tmpFrm;
		}
		else 
		{
			return NULL;
		}
	}	
}

int MemoryLeak5()
{
	FRAMEP_SQ localFrm = NULL;
	
	printf("\n\n\n\t MemoryLeak5 Entry : Total Allocated Bytes = %lu \n", totalBytes_SQ);
	localFrm = FunctionLevel1();	
		
	// Memory allocated for localFrm is not de-allocated 
	printf("\n\n\t MemoryLeak5 Exit : Total Allocated Bytes = %lu \n", totalBytes_SQ);
	
	return 1;
}

int MemoryLeak5_overflow()
{
	FRAMEP_SQ localFrm = NULL;
	char testing[4] = "\0";
	
	printf("\n\n\n\t MemoryLeak5 overflow Entry : Total Allocated Bytes = %lu \n", totalBytes_SQ);
	localFrm = FunctionLevel1();	
		
	// Memory allocated for localFrm is not de-allocated 
	printf("\n\n\t MemoryLeak5 overflow Exit : Total Allocated Bytes = %lu \n", totalBytes_SQ);
	
	strcpy(testing, "abcdefg"); /* array overflow */
	return 1;
}

int NoMemoryLeak5()
{
	FRAMEP_SQ localFrm = NULL;
	
	printf("\n\n\n\t NoMemoryLeak5 Entry : Total Allocated Bytes = %lu \n", totalBytes_SQ);
	localFrm = FunctionLevel1();	
		
	DeleteFrame_SQ(localFrm);
	printf("\n\n\t NoMemoryLeak5 Exit : Total Allocated Bytes = %lu \n", totalBytes_SQ);
	return 1;
}


int MemoryLeak6()
{
	FRAMEP_SQ localFrm = NULL;
	
	printf("\n\n\n\t MemoryLeak6 Entry : Total Allocated Bytes = %lu \n", totalBytes_SQ);
	localFrm = FunctionLevel1();	
	
	localFrm = FunctionLevel3(); /* Memory leak here because localFrm is overwritten */
		
	DeleteFrame_SQ(localFrm);
	printf("\n\n\t MemoryLeak6 Exit : Total Allocated Bytes = %lu \n", totalBytes_SQ);
	return 1;
}

int NoMemoryLeak6()
{
	static FRAMEP_SQ localFrm = NULL;
	
	printf("\n\n\n\t NoMemoryLeak6 Entry : Total Allocated Bytes = %lu \n", totalBytes_SQ);
	if (localFrm == NULL)
		localFrm = FunctionLevel1();	
	
	if (localFrm == NULL)
		localFrm = FunctionLevel3();
	printf("\n\n\t NoMemoryLeak6 Exit : Total Allocated Bytes = %lu \n", totalBytes_SQ);
	
	return 1;
}

int MemoryLeak7()
{
	static FRAMEP_SQ localFrm = NULL;
	
	printf("\n\n\n\t MemoryLeak7 Entry : Total Allocated Bytes = %lu \n", totalBytes_SQ);
	localFrm = FunctionLevel1();	/* static reallocated in next function call */
	printf("\n\n\t MemoryLeak7 Exit : Total Allocated Bytes = %lu \n", totalBytes_SQ);
	
	return 1;
}

int NoMemoryLeak7()
{
	static FRAMEP_SQ localFrm = NULL;
	
	printf("\n\n\n\t NoMemoryLeak7 Entry : Total Allocated Bytes = %lu \n", totalBytes_SQ);
	if (localFrm == NULL)
		localFrm = FunctionLevel1();	/* static reallocated in next function call */
	printf("\n\n\t NoMemoryLeak7 Exit : Total Allocated Bytes = %lu \n", totalBytes_SQ);
	
	return 1;
}


int NullCheck7()
{
	FRAMEP_SQ localFrm = NULL;
	long value = 0;
	
	printf("\n\n\n\t Test 7: NULL check");
	localFrm = FunctionLevel1();
	value = GetFrmVal_SQ(localFrm); /* SQ should throw error as localFrm is used without Null check */
	printf("Test 7 : value = %ld", value);
	
	DeleteFrame_SQ(localFrm);
	return 1;
}

int NullCheck8()
{
	FRAMEP_SQ localFrm = NULL;
	long value = 0;
	
	printf("\n\n\n\t Test 8: NULL check");
	localFrm = CreateFrame_SQ();
	value = GetFrmVal_SQ(localFrm); /* access without Null check */
	printf("Test 8 : value = %ld", value);
	
	DeleteFrame_SQ(localFrm);
	return 1;
}


int main()
{
	int selection = 0;
	int input;
	
	do
	{
		printf("\nEnter a Number: \n\n	\
1. Memory Leak1 Leak with CreateFrm in first function call \n\n	\
2. Memory Leak2 Leak with static CreateFrm in first function call - over-written with CreateFrm \n\n	\
3. Memory Leak3 Leak with static CreateFrm in first function call - overwritten with another AppendElement_SQ \n\n	\
4. Memory Leak4 Leak with CreateDAF_SQ in first function call - not deallocated \n\n	\
5. Memory Leak5 Leak with CreateFrm with multiple function calls\n\n		\
6. Memory Leak6 Leak with CreateFrm being overwritten with multiple function calls\n\n\n		\
7. Memory Leak7 Leak with Leak with static CreateFrm over written in second function call\n\n\n		\
8. Execute Null Check Issue code path createfrm from other function calls\n\n\n		\
9. Null Check Issue code path direct create frame \n\n\n		\
11 to 17 for No Memory Leak paths \n\n\t	\
21 to 22 for Memory leaks with buffer overflow \n\n\t	\
0 to Exit\n\n");
		scanf("%d", &selection);
		
		switch(selection)
		{
			case 1:
				printf("\n\n Execute Memory Leak 1 code path: Leak with CreateFrm in first function call - no de-allocation \n");
				MemoryLeak1();
				break;
			case 2:
				printf("\n\n Execute Memory Leak 2 code path: Leak with static CreateFrm in first function call - over-written with CreateFrm \n");
				MemoryLeak2();
				break;
			case 3:
				printf("\n\n Execute Memory Leak 3 code path: Leak with static CreateFrm in first function call - overwritten with another AppendElement_SQ \n");
				MemoryLeak3();
				break;
			case 4:
				printf("\n\n Execute Memory Leak 4 code path: Leak with CreateDAF_SQ in first function call - not deallocated \n");
				MemoryLeak4();
				break;
			case 5:
				printf("\n\n Execute Memory Leak 5 code path: Leak with CreateFrm with multiple function calls \n");
				MemoryLeak5();
				break;
			case 6:
				printf("\n\n\t Execute Memory Leak 6 code path: Leak with CreateFrm being overwritten with multiple function calls \n");
				MemoryLeak6();
				break;
			case 7:
				printf("\n\n\t Execute Memory Leak 7 code path: Leak with static CreateFrm over written in second function call \n");
				NullCheck7();
				break;
			case 8:
				printf("\n\n\t Execute Null Check Issue code path createfrm from other function calls\n");
				NullCheck7();
				break;
			case 9:
				printf("\n\n\t Execute Null Check Issue code path direct create frame \n");
				NullCheck7();
				break;
			case 11:
				printf("\n\n Execute No Memory Leak 1 code path - CreateFrm is static \n");
				NoMemoryLeak1();
				break;
			case 12:
				printf("\n\n Execute No Memory Leak 2 code path - CreateFrm is de-allocated \n");
				NoMemoryLeak2();
				break;
			case 13:
				printf("\n\n Execute No Memory Leak 3 code path - CreateDAF_SQ with static \n");
				NoMemoryLeak3();
				break;
			case 14:
				printf("\n\n Execute No Memory Leak 4 code path - createDAF deallocated \n");
				NoMemoryLeak4();
				break;
			case 15:
				printf("\n\n Execute No Memory Leak 5 code path - CreateFrm in multiple function calls de-allocated at base function \n");
				NoMemoryLeak5();
				break;
			case 16:
				printf("\n\n Execute No Memory Leak 6 code path - CreateFrm in multiple function calls but static in base function and null check\n");
				NoMemoryLeak6();
				break;
			case 17:
				printf("\n\n Execute No Memory Leak 7 code path - CreateFrm in multiple function calls but static in base function and null check present\n");
				NoMemoryLeak6();
				break;
			case 21:
				printf("\n\n\t Execute Memory Leak 1 with overflow \n");
				NullCheck7();
				break;
			case 22:
				printf("\n\n\t Execute Memory Leak 2 with overflow \n");
				NullCheck7();
				break;
			case 23:
				printf("\n\n\t Execute Memory Leak 5 with overflow \n");
				NullCheck7();
				break;
			case 0:
				printf("\n\n Exiting\n");
				return 1;
			default:
				printf("\n\n Exiting\n");
				break;
		}
		
		printf("Press any number to continue\n\n");
		scanf("%d", &input);
	}while(selection != 0);
	
	return 1;
}
