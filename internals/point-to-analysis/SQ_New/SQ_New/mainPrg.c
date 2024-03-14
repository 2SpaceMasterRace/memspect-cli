
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




int main()
{

	MemoryLeak1();
	MemoryLeak1_overflow();
	NoMemoryLeak1();
	return 1;
}
