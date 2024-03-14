

#include <stdio.h>
#include <stdlib.h>

#define byte 	unsigned char

#define NO_WAIT_REPLY		0
#define	WAIT_REPLY			1

#define VTYPE_SQ           0xF        /* value type mask        */
#define TLONG_SQ           0x0        /* type = long            */
#define TCHAR_SQ           0x4        /* type = char            */
#define TNAME_SQ           0x8        /* type = name            */
#define TFRAME_SQ          0x9        /* type = frame           */
#define LASTTYPE_SQ        0xB        /* the number of types    */

#define INACTIVE_SQ        0x0        /* activity = no action function      */

#define	DAF_BLOCKSIZE_SQ	4
	
#define VAGGR_SQ           0x30       /* aggregate slot mask   */
#define SCALAR_SQ          0x0        /* aggregate = scalar     */
#define ARRAYA_SQ          0x10       /* aggregate = array addr.*/
#define ARRAYR_SQ          0x20       /* aggregate = array rel. */

#define FLAGS_SQ           0xF0       /* special attributes of the frame    */
#define MALLOCED_SQ        0x10       /* frame descendant was malloced      */
	
#define GetFrmName_SQ(frmp)    ((frmp)->name)
#define GetFrmType_SQ(frmp)    ((frmp)->valueSpec & VTYPE_SQ)
#define GetFrmVal_SQ(frmp)     ((frmp)->value)
#define GetFrmFlags_SQ(frmp)   ((frmp)->actSpec   & FLAGS_SQ)

#define SetFrmName_SQ(frmp,name)                                                \
    ((*(long *)(frmp)   = ((name != NULL) ? *(long *)(name) : 0L)))
#define SetFrmType_SQ(frmp,type)                                                \
    ((frmp)->valueSpec = ((frmp)->valueSpec & ~VTYPE_SQ) | (byte)(type))
#define SetFrmUser_SQ(frmp,userVal)                                                \
    ((frmp)->user = (byte)(userVal))
#define SetFrmVal_SQ(frmp,val )                                                 \
    ((frmp)->value    = (long)(val))


#define IsFrmAggr_SQ(frmp,val)    (((frmp) != NULL) && (GetFrmAggr_SQ((frmp))    == (val)) )
#define IsFrmVal_SQ(frmp,val)     (((frmp) != NULL) && (GetFrmVal_SQ((frmp))     == (val)) )  
#define IsFrmFlags_SQ(frmp,val)   (((frmp) != NULL) && (GetFrmFlags_SQ((frmp))    & (val)) )
#define IsFrmType_SQ(frmp,val)    (((frmp) != NULL) && (GetFrmType_SQ((frmp))    == (val)) )	
#define GetArrHdr_SQ(frm)            ((DAFHDRP_SQ)GetFrmVal_SQ((frm)))
#define GetArrDim_SQ(frm)            (GetArrHdr_SQ((frm))->dim)	
#define GetArrRefCnt_SQ(frm)         (GetArrHdr_SQ((frm))->refCnt)
#define GetArrBody_SQ(frm)           (GetArrHdr_SQ((frm))->body)
#define SetArrRefCnt_SQ(frm,val)     (GetArrHdr_SQ((frm))->refCnt = (val))
	
#define GetSizeDAF_SQ(frm)                                                     \
   (((frm != NULL) && IsFrmAggr_SQ(frm,ARRAYA_SQ) && !IsFrmVal_SQ(frm,0l)) ?         \
   		GetArrDim_SQ(frm) : 0)
   
#define GetFirstElement_SQ(frm)                                                 \
   (((frm != NULL) && IsFrmAggr_SQ(frm,ARRAYA_SQ) && !IsFrmVal_SQ(frm,0l) && GetArrDim_SQ(frm)) ? 		 \
     GetArrBody_SQ(frm) : (char*)NULL)
   
#define AppendElement_SQ(owner,field)                                           \
   (((owner) == NULL)? NULL :(AddElement_SQ((owner),GetSizeDAF_SQ((owner)),(field))))

#define HasDescendant_SQ(frmp)                                                  \
    ( (frmp != NULL) &&                                                      \
      (IsFrmAggr_SQ((frmp),ARRAYA_SQ) || IsFrmAggr_SQ((frmp),ARRAYR_SQ)) &&              \
      (GetFrmVal_SQ((frmp)) != 0l))   
	  
#define ResetFrmFlags_SQ(frmp,flag)                                             \
    ((frmp)->actSpec &= ~((flag) & FLAGS_SQ))
	
#define SetFrmAggr_SQ(frmp,aggr)                                                \
    ((frmp)->valueSpec = ((frmp)->valueSpec & ~VAGGR_SQ) | (byte)(aggr))
	
#define SetFrmFlags_SQ(frmp,flag)                                               \
    ((frmp)->actSpec |= ((flag) & FLAGS_SQ))
	
#define GetFrmAggr_SQ(frmp)    ((frmp)->valueSpec & VAGGR_SQ)
#define SetArrDim_SQ(frm,val)        (GetArrHdr_SQ((frm))->dim = (val))
#define SetVSpec_SQ(frmp,vSpc)                                                  \
    ((frmp)->valueSpec = (byte)(vSpc))
#define SetASpec_SQ(frmp,aSpc)                                                  \
    ((frmp)->actSpec = (byte)(aSpc))
#define SetFrmClass_SQ(frmp,classVal)                                           \
    ((frmp)->class = (byte)(classVal))

 
   
typedef char 	*LPSTR_SQ;
	
/*
 *------------------------------------------------------------------------
 *
 *  The following typedef defines the "frame" data type. 
 *  FRAMES_SQ is a type that represents a frame,
 *  whereas FRAMEP_SQ is a type that represents the address of a frame.
 *
 *------------------------------------------------------------------------
 */
typedef struct frameStruct_SQ
{
    char    name[4];    /* name of the frame; 4 ascii chars                 */
    byte    valueSpec;  /* bits 0-3 type; bits 4-5 aggregate;               */
    byte    actSpec;    /* 0 INACTIVE_SQ; 1 GETVALUE; 2 SETVALUE;              */
    byte    user;       /* user reserved  byte                               */
    byte    class;      /* ancestor class type. Used for inheritance        */
    long    value;      /* value associated with this frame                 */
} FRAMES_SQ, *FRAMEP_SQ;
/*
 *  Pointer to function returning frame
 */
typedef FRAMEP_SQ 	(* funcp)();


typedef struct dafHdrStruct_SQ
{
    char  *body;     /* a pointer to the array body         */
    short refCnt;    /* the reference count for the DAF     */
    short dim;       /* the number of elements of the array */
} DAFHDR_SQ, *DAFHDRP_SQ;


byte typeSize_SQ[LASTTYPE_SQ + 1] = { sizeof(long),
                                sizeof(unsigned long),
                                sizeof(short),
                                sizeof(unsigned short),
                                sizeof(char),
                                sizeof(unsigned char),
                                sizeof(float),
                                sizeof(double),
                                sizeof(char[4]),
                                sizeof(FRAMES_SQ),
                                sizeof(char[4]),
								sizeof(char)
                              };

unsigned long totalBytes_SQ = 0;

FRAMEP_SQ CreateFrame_SQ();
FRAMEP_SQ CreateDAF_SQ(FRAMEP_SQ owner, short dim);
void	*Calloc_SQ(unsigned int n, unsigned int size);
char *AddElement_SQ(FRAMEP_SQ owner,short position, void *element);
FRAMEP_SQ	PutStringDAF_SQ(FRAMEP_SQ frm, LPSTR_SQ str);
void	Cfree_SQ(void *ptr);
FRAMEP_SQ  FillFrame_SQ(FRAMEP_SQ frm, LPSTR_SQ name, 
						  byte vspec, byte aspec, byte user, byte class,
						  long value);
FRAMEP_SQ DeleteDAF_SQ(FRAMEP_SQ owner);
FRAMEP_SQ DeleteFrame_SQ(FRAMEP_SQ owner);

void	*Calloc_SQ(unsigned int n, unsigned int size)
{
	char *storage;

	if (size*n <= 0)
		return NULL;
	
	if ( (storage = malloc(n*size + sizeof(unsigned int))) == NULL )
	{
		printf(" out of heap while allocating %u bytes\n",n*size);
		return NULL;
	}
	else
	{
		memset(storage + sizeof(unsigned int),0,n*size);
		*(unsigned int *)storage = (n*size) + sizeof(unsigned int);
		totalBytes_SQ += (n*size) + sizeof(unsigned int);

		printf("Calloc_SQ : totalBytes_SQ = %lu delta = +%u at %p\n",
			        totalBytes_SQ,n*size+sizeof(unsigned long),storage);

		storage = storage + sizeof(unsigned int);
		return storage;
	}
}

FRAMEP_SQ CreateFrame_SQ()
{
	return (FRAMEP_SQ)Calloc_SQ(1,sizeof(FRAMES_SQ));
}

