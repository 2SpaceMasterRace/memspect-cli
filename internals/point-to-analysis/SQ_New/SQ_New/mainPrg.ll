; ModuleID = 'mainPrg.c'
source_filename = "mainPrg.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.frameStruct_SQ = type { [4 x i8], i8, i8, i8, i8, i64 }
%struct.dafHdrStruct_SQ = type { ptr, i16, i16 }

@typeSize_SQ = dso_local global [12 x i8] c"\08\08\02\02\01\01\04\08\04\10\04\01", align 1
@totalBytes_SQ = dso_local global i64 0, align 8
@.str = private unnamed_addr constant [40 x i8] c" out of heap while allocating %u bytes\0A\00", align 1
@.str.1 = private unnamed_addr constant [51 x i8] c"Calloc_SQ : totalBytes_SQ = %lu delta = +%u at %p\0A\00", align 1
@.str.2 = private unnamed_addr constant [5 x i8] c"NODE\00", align 1
@.str.3 = private unnamed_addr constant [50 x i8] c"Cfree_SQ : totalBytes_SQ = %lu delta = -%u at %p\0A\00", align 1
@.str.4 = private unnamed_addr constant [55 x i8] c"\0A\0A\0A\09 MemoryLeak1 Entry : Total Allocated Bytes = %lu \0A\00", align 1
@.str.5 = private unnamed_addr constant [5 x i8] c"amFr\00", align 1
@.str.6 = private unnamed_addr constant [53 x i8] c"\0A\0A\09 MemoryLeak1 Exit : Total Allocated Bytes = %lu \0A\00", align 1
@.str.7 = private unnamed_addr constant [64 x i8] c"\0A\0A\0A\09 MemoryLeak1 overflow Entry : Total Allocated Bytes = %lu \0A\00", align 1
@.str.8 = private unnamed_addr constant [62 x i8] c"\0A\0A\09 MemoryLeak1 overflow Exit : Total Allocated Bytes = %lu \0A\00", align 1
@.str.9 = private unnamed_addr constant [8 x i8] c"abcdefg\00", align 1
@NoMemoryLeak1.localFrm = internal global ptr null, align 8
@.str.10 = private unnamed_addr constant [57 x i8] c"\0A\0A\0A\09 NoMemoryLeak1 Entry : Total Allocated Bytes = %lu \0A\00", align 1
@.str.11 = private unnamed_addr constant [55 x i8] c"\0A\0A\09 NoMemoryLeak1 Exit : Total Allocated Bytes = %lu \0A\00", align 1
@.str.12 = private unnamed_addr constant [57 x i8] c"\0A\0A\0A\09 NoMemoryLeak2 Entry : Total Allocated Bytes = %lu \0A\00", align 1
@.str.13 = private unnamed_addr constant [55 x i8] c"\0A\0A\09 NoMemoryLeak2 Exit : Total Allocated Bytes = %lu \0A\00", align 1
@MemoryLeak2.localFrm = internal global ptr null, align 8
@.str.14 = private unnamed_addr constant [55 x i8] c"\0A\0A\0A\09 MemoryLeak2 Entry : Total Allocated Bytes = %lu \0A\00", align 1
@.str.15 = private unnamed_addr constant [54 x i8] c"\0A\0A\0A\09 MemoryLeak2 Exit : Total Allocated Bytes = %lu \0A\00", align 1
@MemoryLeak2_overflow.localFrm = internal global ptr null, align 8
@.str.16 = private unnamed_addr constant [64 x i8] c"\0A\0A\0A\09 MemoryLeak2 overflow Entry : Total Allocated Bytes = %lu \0A\00", align 1
@.str.17 = private unnamed_addr constant [63 x i8] c"\0A\0A\0A\09 MemoryLeak2 overflow Exit : Total Allocated Bytes = %lu \0A\00", align 1
@MemoryLeak3.localFrm = internal global ptr null, align 8
@MemoryLeak3.localDAF = internal global ptr null, align 8
@.str.18 = private unnamed_addr constant [55 x i8] c"\0A\0A\0A\09 MemoryLeak3 Entry : Total Allocated Bytes = %lu \0A\00", align 1
@.str.19 = private unnamed_addr constant [5 x i8] c"amdf\00", align 1
@.str.20 = private unnamed_addr constant [53 x i8] c"\0A\0A\09 MemoryLeak3 Exit : Total Allocated Bytes = %lu \0A\00", align 1
@.str.21 = private unnamed_addr constant [55 x i8] c"\0A\0A\0A\09 MemoryLeak4 Entry : Total Allocated Bytes = %lu \0A\00", align 1
@.str.22 = private unnamed_addr constant [53 x i8] c"\0A\0A\09 MemoryLeak4 Exit : Total Allocated Bytes = %lu \0A\00", align 1
@NoMemoryLeak3.localDAF = internal global ptr null, align 8
@.str.23 = private unnamed_addr constant [57 x i8] c"\0A\0A\0A\09 NoMemoryLeak3 Entry : Total Allocated Bytes = %lu \0A\00", align 1
@.str.24 = private unnamed_addr constant [55 x i8] c"\0A\0A\09 NoMemoryLeak3 Exit : Total Allocated Bytes = %lu \0A\00", align 1
@.str.25 = private unnamed_addr constant [57 x i8] c"\0A\0A\0A\09 NoMemoryLeak4 Entry : Total Allocated Bytes = %lu \0A\00", align 1
@.str.26 = private unnamed_addr constant [55 x i8] c"\0A\0A\09 NoMemoryLeak4 Exit : Total Allocated Bytes = %lu \0A\00", align 1
@.str.27 = private unnamed_addr constant [35 x i8] c"Value of the frame created is : %d\00", align 1
@.str.28 = private unnamed_addr constant [5 x i8] c"here\00", align 1
@.str.29 = private unnamed_addr constant [55 x i8] c"\0A\0A\0A\09 MemoryLeak5 Entry : Total Allocated Bytes = %lu \0A\00", align 1
@.str.30 = private unnamed_addr constant [53 x i8] c"\0A\0A\09 MemoryLeak5 Exit : Total Allocated Bytes = %lu \0A\00", align 1
@.str.31 = private unnamed_addr constant [64 x i8] c"\0A\0A\0A\09 MemoryLeak5 overflow Entry : Total Allocated Bytes = %lu \0A\00", align 1
@.str.32 = private unnamed_addr constant [62 x i8] c"\0A\0A\09 MemoryLeak5 overflow Exit : Total Allocated Bytes = %lu \0A\00", align 1
@.str.33 = private unnamed_addr constant [57 x i8] c"\0A\0A\0A\09 NoMemoryLeak5 Entry : Total Allocated Bytes = %lu \0A\00", align 1
@.str.34 = private unnamed_addr constant [55 x i8] c"\0A\0A\09 NoMemoryLeak5 Exit : Total Allocated Bytes = %lu \0A\00", align 1
@.str.35 = private unnamed_addr constant [55 x i8] c"\0A\0A\0A\09 MemoryLeak6 Entry : Total Allocated Bytes = %lu \0A\00", align 1
@.str.36 = private unnamed_addr constant [53 x i8] c"\0A\0A\09 MemoryLeak6 Exit : Total Allocated Bytes = %lu \0A\00", align 1
@NoMemoryLeak6.localFrm = internal global ptr null, align 8
@.str.37 = private unnamed_addr constant [57 x i8] c"\0A\0A\0A\09 NoMemoryLeak6 Entry : Total Allocated Bytes = %lu \0A\00", align 1
@.str.38 = private unnamed_addr constant [55 x i8] c"\0A\0A\09 NoMemoryLeak6 Exit : Total Allocated Bytes = %lu \0A\00", align 1
@MemoryLeak7.localFrm = internal global ptr null, align 8
@.str.39 = private unnamed_addr constant [55 x i8] c"\0A\0A\0A\09 MemoryLeak7 Entry : Total Allocated Bytes = %lu \0A\00", align 1
@.str.40 = private unnamed_addr constant [53 x i8] c"\0A\0A\09 MemoryLeak7 Exit : Total Allocated Bytes = %lu \0A\00", align 1
@NoMemoryLeak7.localFrm = internal global ptr null, align 8
@.str.41 = private unnamed_addr constant [57 x i8] c"\0A\0A\0A\09 NoMemoryLeak7 Entry : Total Allocated Bytes = %lu \0A\00", align 1
@.str.42 = private unnamed_addr constant [55 x i8] c"\0A\0A\09 NoMemoryLeak7 Exit : Total Allocated Bytes = %lu \0A\00", align 1
@.str.43 = private unnamed_addr constant [24 x i8] c"\0A\0A\0A\09 Test 7: NULL check\00", align 1
@.str.44 = private unnamed_addr constant [21 x i8] c"Test 7 : value = %ld\00", align 1
@.str.45 = private unnamed_addr constant [24 x i8] c"\0A\0A\0A\09 Test 8: NULL check\00", align 1
@.str.46 = private unnamed_addr constant [21 x i8] c"Test 8 : value = %ld\00", align 1
@.str.47 = private unnamed_addr constant [860 x i8] c"\0AEnter a Number: \0A\0A\091. Memory Leak1 Leak with CreateFrm in first function call \0A\0A\092. Memory Leak2 Leak with static CreateFrm in first function call - over-written with CreateFrm \0A\0A\093. Memory Leak3 Leak with static CreateFrm in first function call - overwritten with another AppendElement_SQ \0A\0A\094. Memory Leak4 Leak with CreateDAF_SQ in first function call - not deallocated \0A\0A\095. Memory Leak5 Leak with CreateFrm with multiple function calls\0A\0A\09\096. Memory Leak6 Leak with CreateFrm being overwritten with multiple function calls\0A\0A\0A\09\097. Memory Leak7 Leak with Leak with static CreateFrm over written in second function call\0A\0A\0A\09\098. Execute Null Check Issue code path createfrm from other function calls\0A\0A\0A\09\099. Null Check Issue code path direct create frame \0A\0A\0A\09\0911 to 17 for No Memory Leak paths \0A\0A\09\0921 to 22 for Memory leaks with buffer overflow \0A\0A\09\090 to Exit\0A\0A\00", align 1
@.str.48 = private unnamed_addr constant [3 x i8] c"%d\00", align 1
@.str.49 = private unnamed_addr constant [100 x i8] c"\0A\0A Execute Memory Leak 1 code path: Leak with CreateFrm in first function call - no de-allocation \0A\00", align 1
@.str.50 = private unnamed_addr constant [118 x i8] c"\0A\0A Execute Memory Leak 2 code path: Leak with static CreateFrm in first function call - over-written with CreateFrm \0A\00", align 1
@.str.51 = private unnamed_addr constant [132 x i8] c"\0A\0A Execute Memory Leak 3 code path: Leak with static CreateFrm in first function call - overwritten with another AppendElement_SQ \0A\00", align 1
@.str.52 = private unnamed_addr constant [102 x i8] c"\0A\0A Execute Memory Leak 4 code path: Leak with CreateDAF_SQ in first function call - not deallocated \0A\00", align 1
@.str.53 = private unnamed_addr constant [87 x i8] c"\0A\0A Execute Memory Leak 5 code path: Leak with CreateFrm with multiple function calls \0A\00", align 1
@.str.54 = private unnamed_addr constant [106 x i8] c"\0A\0A\09 Execute Memory Leak 6 code path: Leak with CreateFrm being overwritten with multiple function calls \0A\00", align 1
@.str.55 = private unnamed_addr constant [103 x i8] c"\0A\0A\09 Execute Memory Leak 7 code path: Leak with static CreateFrm over written in second function call \0A\00", align 1
@.str.56 = private unnamed_addr constant [76 x i8] c"\0A\0A\09 Execute Null Check Issue code path createfrm from other function calls\0A\00", align 1
@.str.57 = private unnamed_addr constant [61 x i8] c"\0A\0A\09 Execute Null Check Issue code path direct create frame \0A\00", align 1
@.str.58 = private unnamed_addr constant [62 x i8] c"\0A\0A Execute No Memory Leak 1 code path - CreateFrm is static \0A\00", align 1
@.str.59 = private unnamed_addr constant [68 x i8] c"\0A\0A Execute No Memory Leak 2 code path - CreateFrm is de-allocated \0A\00", align 1
@.str.60 = private unnamed_addr constant [67 x i8] c"\0A\0A Execute No Memory Leak 3 code path - CreateDAF_SQ with static \0A\00", align 1
@.str.61 = private unnamed_addr constant [64 x i8] c"\0A\0A Execute No Memory Leak 4 code path - createDAF deallocated \0A\00", align 1
@.str.62 = private unnamed_addr constant [109 x i8] c"\0A\0A Execute No Memory Leak 5 code path - CreateFrm in multiple function calls de-allocated at base function \0A\00", align 1
@.str.63 = private unnamed_addr constant [121 x i8] c"\0A\0A Execute No Memory Leak 6 code path - CreateFrm in multiple function calls but static in base function and null check\0A\00", align 1
@.str.64 = private unnamed_addr constant [129 x i8] c"\0A\0A Execute No Memory Leak 7 code path - CreateFrm in multiple function calls but static in base function and null check present\0A\00", align 1
@.str.65 = private unnamed_addr constant [42 x i8] c"\0A\0A\09 Execute Memory Leak 1 with overflow \0A\00", align 1
@.str.66 = private unnamed_addr constant [42 x i8] c"\0A\0A\09 Execute Memory Leak 2 with overflow \0A\00", align 1
@.str.67 = private unnamed_addr constant [42 x i8] c"\0A\0A\09 Execute Memory Leak 5 with overflow \0A\00", align 1
@.str.68 = private unnamed_addr constant [12 x i8] c"\0A\0A Exiting\0A\00", align 1
@.str.69 = private unnamed_addr constant [31 x i8] c"Press any number to continue\0A\0A\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local ptr @Calloc_SQ(i32 noundef %0, i32 noundef %1) #0 {
  %3 = alloca ptr, align 8
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca ptr, align 8
  store i32 %0, ptr %4, align 4
  store i32 %1, ptr %5, align 4
  %7 = load i32, ptr %5, align 4
  %8 = load i32, ptr %4, align 4
  %9 = mul i32 %7, %8
  %10 = icmp ule i32 %9, 0
  br i1 %10, label %11, label %12

11:                                               ; preds = %2
  store ptr null, ptr %3, align 8
  br label %57

12:                                               ; preds = %2
  %13 = load i32, ptr %4, align 4
  %14 = load i32, ptr %5, align 4
  %15 = mul i32 %13, %14
  %16 = zext i32 %15 to i64
  %17 = add i64 %16, 4
  %18 = call noalias ptr @malloc(i64 noundef %17) #7
  store ptr %18, ptr %6, align 8
  %19 = icmp eq ptr %18, null
  br i1 %19, label %20, label %25

20:                                               ; preds = %12
  %21 = load i32, ptr %4, align 4
  %22 = load i32, ptr %5, align 4
  %23 = mul i32 %21, %22
  %24 = call i32 (ptr, ...) @printf(ptr noundef @.str, i32 noundef %23)
  store ptr null, ptr %3, align 8
  br label %57

25:                                               ; preds = %12
  %26 = load ptr, ptr %6, align 8
  %27 = getelementptr inbounds i8, ptr %26, i64 4
  %28 = load i32, ptr %4, align 4
  %29 = load i32, ptr %5, align 4
  %30 = mul i32 %28, %29
  %31 = zext i32 %30 to i64
  call void @llvm.memset.p0.i64(ptr align 1 %27, i8 0, i64 %31, i1 false)
  %32 = load i32, ptr %4, align 4
  %33 = load i32, ptr %5, align 4
  %34 = mul i32 %32, %33
  %35 = zext i32 %34 to i64
  %36 = add i64 %35, 4
  %37 = trunc i64 %36 to i32
  %38 = load ptr, ptr %6, align 8
  store i32 %37, ptr %38, align 4
  %39 = load i32, ptr %4, align 4
  %40 = load i32, ptr %5, align 4
  %41 = mul i32 %39, %40
  %42 = zext i32 %41 to i64
  %43 = add i64 %42, 4
  %44 = load i64, ptr @totalBytes_SQ, align 8
  %45 = add i64 %44, %43
  store i64 %45, ptr @totalBytes_SQ, align 8
  %46 = load i64, ptr @totalBytes_SQ, align 8
  %47 = load i32, ptr %4, align 4
  %48 = load i32, ptr %5, align 4
  %49 = mul i32 %47, %48
  %50 = zext i32 %49 to i64
  %51 = add i64 %50, 4
  %52 = load ptr, ptr %6, align 8
  %53 = call i32 (ptr, ...) @printf(ptr noundef @.str.1, i64 noundef %46, i64 noundef %51, ptr noundef %52)
  %54 = load ptr, ptr %6, align 8
  %55 = getelementptr inbounds i8, ptr %54, i64 4
  store ptr %55, ptr %6, align 8
  %56 = load ptr, ptr %6, align 8
  store ptr %56, ptr %3, align 8
  br label %57

57:                                               ; preds = %25, %20, %11
  %58 = load ptr, ptr %3, align 8
  ret ptr %58
}

; Function Attrs: nounwind allocsize(0)
declare noalias ptr @malloc(i64 noundef) #1

declare i32 @printf(ptr noundef, ...) #2

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: write)
declare void @llvm.memset.p0.i64(ptr nocapture writeonly, i8, i64, i1 immarg) #3

; Function Attrs: noinline nounwind optnone uwtable
define dso_local ptr @CreateFrame_SQ() #0 {
  %1 = call ptr @Calloc_SQ(i32 noundef 1, i32 noundef 16)
  ret ptr %1
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local ptr @CreateDAF_SQ(ptr noundef %0, i16 noundef signext %1) #0 {
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  %5 = alloca i16, align 2
  %6 = alloca ptr, align 8
  %7 = alloca i16, align 2
  %8 = alloca i16, align 2
  store ptr %0, ptr %4, align 8
  store i16 %1, ptr %5, align 2
  store i16 0, ptr %7, align 2
  %9 = load i16, ptr %5, align 2
  %10 = sext i16 %9 to i32
  %11 = icmp slt i32 %10, 0
  br i1 %11, label %22, label %12

12:                                               ; preds = %2
  %13 = load ptr, ptr %4, align 8
  %14 = icmp ne ptr %13, null
  br i1 %14, label %15, label %23

15:                                               ; preds = %12
  %16 = load ptr, ptr %4, align 8
  %17 = getelementptr inbounds %struct.frameStruct_SQ, ptr %16, i32 0, i32 1
  %18 = load i8, ptr %17, align 4
  %19 = zext i8 %18 to i32
  %20 = and i32 %19, 15
  %21 = icmp sgt i32 %20, 11
  br i1 %21, label %22, label %23

22:                                               ; preds = %15, %2
  store ptr null, ptr %3, align 8
  br label %106

23:                                               ; preds = %15, %12
  %24 = load ptr, ptr %4, align 8
  %25 = icmp eq ptr %24, null
  br i1 %25, label %26, label %35

26:                                               ; preds = %23
  %27 = call ptr @Calloc_SQ(i32 noundef 1, i32 noundef 16)
  store ptr %27, ptr %4, align 8
  %28 = icmp eq ptr %27, null
  br i1 %28, label %29, label %30

29:                                               ; preds = %26
  store ptr null, ptr %3, align 8
  br label %106

30:                                               ; preds = %26
  %31 = load ptr, ptr %4, align 8
  %32 = call ptr @FillFrame_SQ(ptr noundef %31, ptr noundef @.str.2, i8 noundef zeroext 9, i8 noundef zeroext 0, i8 noundef zeroext 0, i8 noundef zeroext 0, i64 noundef 0)
  %33 = load i16, ptr %7, align 2
  %34 = add i16 %33, 1
  store i16 %34, ptr %7, align 2
  br label %38

35:                                               ; preds = %23
  %36 = load ptr, ptr %4, align 8
  %37 = call ptr @DeleteDAF_SQ(ptr noundef %36)
  br label %38

38:                                               ; preds = %35, %30
  %39 = call ptr @Calloc_SQ(i32 noundef 1, i32 noundef 16)
  store ptr %39, ptr %6, align 8
  %40 = icmp eq ptr %39, null
  br i1 %40, label %41, label %42

41:                                               ; preds = %38
  store ptr null, ptr %3, align 8
  br label %106

42:                                               ; preds = %38
  %43 = load i16, ptr %5, align 2
  %44 = sext i16 %43 to i32
  %45 = icmp sgt i32 %44, 0
  br i1 %45, label %46, label %77

46:                                               ; preds = %42
  %47 = load i16, ptr %5, align 2
  %48 = sext i16 %47 to i32
  %49 = sdiv i32 %48, 4
  %50 = add nsw i32 %49, 1
  %51 = mul nsw i32 %50, 4
  %52 = trunc i32 %51 to i16
  store i16 %52, ptr %8, align 2
  %53 = load i16, ptr %8, align 2
  %54 = sext i16 %53 to i32
  %55 = load ptr, ptr %4, align 8
  %56 = getelementptr inbounds %struct.frameStruct_SQ, ptr %55, i32 0, i32 1
  %57 = load i8, ptr %56, align 4
  %58 = zext i8 %57 to i32
  %59 = and i32 %58, 15
  %60 = sext i32 %59 to i64
  %61 = getelementptr inbounds [12 x i8], ptr @typeSize_SQ, i64 0, i64 %60
  %62 = load i8, ptr %61, align 1
  %63 = zext i8 %62 to i32
  %64 = mul nsw i32 %54, %63
  %65 = call ptr @Calloc_SQ(i32 noundef %64, i32 noundef 1)
  %66 = load ptr, ptr %6, align 8
  %67 = getelementptr inbounds %struct.dafHdrStruct_SQ, ptr %66, i32 0, i32 0
  store ptr %65, ptr %67, align 8
  %68 = icmp eq ptr %65, null
  br i1 %68, label %69, label %76

69:                                               ; preds = %46
  %70 = load ptr, ptr %6, align 8
  call void @Cfree_SQ(ptr noundef %70)
  %71 = load i16, ptr %7, align 2
  %72 = icmp ne i16 %71, 0
  br i1 %72, label %73, label %75

73:                                               ; preds = %69
  %74 = load ptr, ptr %4, align 8
  call void @Cfree_SQ(ptr noundef %74)
  br label %75

75:                                               ; preds = %73, %69
  store ptr null, ptr %3, align 8
  br label %106

76:                                               ; preds = %46
  br label %80

77:                                               ; preds = %42
  %78 = load ptr, ptr %6, align 8
  %79 = getelementptr inbounds %struct.dafHdrStruct_SQ, ptr %78, i32 0, i32 0
  store ptr null, ptr %79, align 8
  br label %80

80:                                               ; preds = %77, %76
  %81 = load ptr, ptr %6, align 8
  %82 = getelementptr inbounds %struct.dafHdrStruct_SQ, ptr %81, i32 0, i32 1
  store i16 1, ptr %82, align 8
  %83 = load i16, ptr %5, align 2
  %84 = load ptr, ptr %6, align 8
  %85 = getelementptr inbounds %struct.dafHdrStruct_SQ, ptr %84, i32 0, i32 2
  store i16 %83, ptr %85, align 2
  %86 = load ptr, ptr %6, align 8
  %87 = ptrtoint ptr %86 to i64
  %88 = load ptr, ptr %4, align 8
  %89 = getelementptr inbounds %struct.frameStruct_SQ, ptr %88, i32 0, i32 5
  store i64 %87, ptr %89, align 8
  %90 = load ptr, ptr %4, align 8
  %91 = getelementptr inbounds %struct.frameStruct_SQ, ptr %90, i32 0, i32 1
  %92 = load i8, ptr %91, align 4
  %93 = zext i8 %92 to i32
  %94 = and i32 %93, -49
  %95 = or i32 %94, 16
  %96 = trunc i32 %95 to i8
  %97 = load ptr, ptr %4, align 8
  %98 = getelementptr inbounds %struct.frameStruct_SQ, ptr %97, i32 0, i32 1
  store i8 %96, ptr %98, align 4
  %99 = load ptr, ptr %4, align 8
  %100 = getelementptr inbounds %struct.frameStruct_SQ, ptr %99, i32 0, i32 2
  %101 = load i8, ptr %100, align 1
  %102 = zext i8 %101 to i32
  %103 = or i32 %102, 16
  %104 = trunc i32 %103 to i8
  store i8 %104, ptr %100, align 1
  %105 = load ptr, ptr %4, align 8
  store ptr %105, ptr %3, align 8
  br label %106

106:                                              ; preds = %80, %75, %41, %29, %22
  %107 = load ptr, ptr %3, align 8
  ret ptr %107
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local ptr @FillFrame_SQ(ptr noundef %0, ptr noundef %1, i8 noundef zeroext %2, i8 noundef zeroext %3, i8 noundef zeroext %4, i8 noundef zeroext %5, i64 noundef %6) #0 {
  %8 = alloca ptr, align 8
  %9 = alloca ptr, align 8
  %10 = alloca ptr, align 8
  %11 = alloca i8, align 1
  %12 = alloca i8, align 1
  %13 = alloca i8, align 1
  %14 = alloca i8, align 1
  %15 = alloca i64, align 8
  store ptr %0, ptr %9, align 8
  store ptr %1, ptr %10, align 8
  store i8 %2, ptr %11, align 1
  store i8 %3, ptr %12, align 1
  store i8 %4, ptr %13, align 1
  store i8 %5, ptr %14, align 1
  store i64 %6, ptr %15, align 8
  %16 = load ptr, ptr %9, align 8
  %17 = icmp eq ptr %16, null
  br i1 %17, label %18, label %19

18:                                               ; preds = %7
  store ptr null, ptr %8, align 8
  br label %45

19:                                               ; preds = %7
  %20 = load ptr, ptr %10, align 8
  %21 = icmp ne ptr %20, null
  br i1 %21, label %22, label %25

22:                                               ; preds = %19
  %23 = load ptr, ptr %10, align 8
  %24 = load i64, ptr %23, align 8
  br label %26

25:                                               ; preds = %19
  br label %26

26:                                               ; preds = %25, %22
  %27 = phi i64 [ %24, %22 ], [ 0, %25 ]
  %28 = load ptr, ptr %9, align 8
  store i64 %27, ptr %28, align 8
  %29 = load i8, ptr %11, align 1
  %30 = load ptr, ptr %9, align 8
  %31 = getelementptr inbounds %struct.frameStruct_SQ, ptr %30, i32 0, i32 1
  store i8 %29, ptr %31, align 4
  %32 = load i8, ptr %12, align 1
  %33 = load ptr, ptr %9, align 8
  %34 = getelementptr inbounds %struct.frameStruct_SQ, ptr %33, i32 0, i32 2
  store i8 %32, ptr %34, align 1
  %35 = load i8, ptr %13, align 1
  %36 = load ptr, ptr %9, align 8
  %37 = getelementptr inbounds %struct.frameStruct_SQ, ptr %36, i32 0, i32 3
  store i8 %35, ptr %37, align 2
  %38 = load i8, ptr %14, align 1
  %39 = load ptr, ptr %9, align 8
  %40 = getelementptr inbounds %struct.frameStruct_SQ, ptr %39, i32 0, i32 4
  store i8 %38, ptr %40, align 1
  %41 = load i64, ptr %15, align 8
  %42 = load ptr, ptr %9, align 8
  %43 = getelementptr inbounds %struct.frameStruct_SQ, ptr %42, i32 0, i32 5
  store i64 %41, ptr %43, align 8
  %44 = load ptr, ptr %9, align 8
  store ptr %44, ptr %8, align 8
  br label %45

45:                                               ; preds = %26, %18
  %46 = load ptr, ptr %8, align 8
  ret ptr %46
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local ptr @DeleteDAF_SQ(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  %6 = alloca ptr, align 8
  %7 = alloca i16, align 2
  %8 = alloca i16, align 2
  store ptr %0, ptr %3, align 8
  %9 = load ptr, ptr %3, align 8
  %10 = icmp eq ptr %9, null
  br i1 %10, label %39, label %11

11:                                               ; preds = %1
  %12 = load ptr, ptr %3, align 8
  %13 = icmp ne ptr %12, null
  br i1 %13, label %14, label %39

14:                                               ; preds = %11
  %15 = load ptr, ptr %3, align 8
  %16 = icmp ne ptr %15, null
  br i1 %16, label %17, label %24

17:                                               ; preds = %14
  %18 = load ptr, ptr %3, align 8
  %19 = getelementptr inbounds %struct.frameStruct_SQ, ptr %18, i32 0, i32 1
  %20 = load i8, ptr %19, align 4
  %21 = zext i8 %20 to i32
  %22 = and i32 %21, 48
  %23 = icmp eq i32 %22, 16
  br i1 %23, label %34, label %24

24:                                               ; preds = %17, %14
  %25 = load ptr, ptr %3, align 8
  %26 = icmp ne ptr %25, null
  br i1 %26, label %27, label %39

27:                                               ; preds = %24
  %28 = load ptr, ptr %3, align 8
  %29 = getelementptr inbounds %struct.frameStruct_SQ, ptr %28, i32 0, i32 1
  %30 = load i8, ptr %29, align 4
  %31 = zext i8 %30 to i32
  %32 = and i32 %31, 48
  %33 = icmp eq i32 %32, 32
  br i1 %33, label %34, label %39

34:                                               ; preds = %27, %17
  %35 = load ptr, ptr %3, align 8
  %36 = getelementptr inbounds %struct.frameStruct_SQ, ptr %35, i32 0, i32 5
  %37 = load i64, ptr %36, align 8
  %38 = icmp ne i64 %37, 0
  br i1 %38, label %41, label %39

39:                                               ; preds = %34, %27, %24, %11, %1
  %40 = load ptr, ptr %3, align 8
  store ptr %40, ptr %2, align 8
  br label %131

41:                                               ; preds = %34
  %42 = load ptr, ptr %3, align 8
  %43 = icmp ne ptr %42, null
  br i1 %43, label %44, label %110

44:                                               ; preds = %41
  %45 = load ptr, ptr %3, align 8
  %46 = getelementptr inbounds %struct.frameStruct_SQ, ptr %45, i32 0, i32 2
  %47 = load i8, ptr %46, align 1
  %48 = zext i8 %47 to i32
  %49 = and i32 %48, 240
  %50 = and i32 %49, 16
  %51 = icmp ne i32 %50, 0
  br i1 %51, label %52, label %110

52:                                               ; preds = %44
  %53 = load ptr, ptr %3, align 8
  %54 = getelementptr inbounds %struct.frameStruct_SQ, ptr %53, i32 0, i32 5
  %55 = load i64, ptr %54, align 8
  %56 = inttoptr i64 %55 to ptr
  %57 = getelementptr inbounds %struct.dafHdrStruct_SQ, ptr %56, i32 0, i32 1
  %58 = load i16, ptr %57, align 8
  %59 = add i16 %58, -1
  store i16 %59, ptr %57, align 8
  %60 = sext i16 %59 to i32
  %61 = icmp eq i32 %60, 0
  br i1 %61, label %62, label %110

62:                                               ; preds = %52
  %63 = load ptr, ptr %3, align 8
  %64 = getelementptr inbounds %struct.frameStruct_SQ, ptr %63, i32 0, i32 5
  %65 = load i64, ptr %64, align 8
  %66 = inttoptr i64 %65 to ptr
  %67 = getelementptr inbounds %struct.dafHdrStruct_SQ, ptr %66, i32 0, i32 0
  %68 = load ptr, ptr %67, align 8
  store ptr %68, ptr %6, align 8
  %69 = icmp ne ptr %68, null
  br i1 %69, label %70, label %105

70:                                               ; preds = %62
  %71 = load ptr, ptr %3, align 8
  %72 = icmp ne ptr %71, null
  br i1 %72, label %73, label %103

73:                                               ; preds = %70
  %74 = load ptr, ptr %3, align 8
  %75 = getelementptr inbounds %struct.frameStruct_SQ, ptr %74, i32 0, i32 1
  %76 = load i8, ptr %75, align 4
  %77 = zext i8 %76 to i32
  %78 = and i32 %77, 15
  %79 = icmp eq i32 %78, 9
  br i1 %79, label %80, label %103

80:                                               ; preds = %73
  %81 = load ptr, ptr %6, align 8
  store ptr %81, ptr %4, align 8
  %82 = load ptr, ptr %3, align 8
  %83 = getelementptr inbounds %struct.frameStruct_SQ, ptr %82, i32 0, i32 5
  %84 = load i64, ptr %83, align 8
  %85 = inttoptr i64 %84 to ptr
  %86 = getelementptr inbounds %struct.dafHdrStruct_SQ, ptr %85, i32 0, i32 2
  %87 = load i16, ptr %86, align 2
  store i16 %87, ptr %7, align 2
  store i16 0, ptr %8, align 2
  br label %88

88:                                               ; preds = %97, %80
  %89 = load i16, ptr %8, align 2
  %90 = sext i16 %89 to i32
  %91 = load i16, ptr %7, align 2
  %92 = sext i16 %91 to i32
  %93 = icmp slt i32 %90, %92
  br i1 %93, label %94, label %102

94:                                               ; preds = %88
  %95 = load ptr, ptr %4, align 8
  %96 = call ptr @DeleteDAF_SQ(ptr noundef %95)
  br label %97

97:                                               ; preds = %94
  %98 = load i16, ptr %8, align 2
  %99 = add i16 %98, 1
  store i16 %99, ptr %8, align 2
  %100 = load ptr, ptr %4, align 8
  %101 = getelementptr inbounds %struct.frameStruct_SQ, ptr %100, i32 1
  store ptr %101, ptr %4, align 8
  br label %88, !llvm.loop !6

102:                                              ; preds = %88
  br label %103

103:                                              ; preds = %102, %73, %70
  %104 = load ptr, ptr %6, align 8
  call void @Cfree_SQ(ptr noundef %104)
  br label %105

105:                                              ; preds = %103, %62
  %106 = load ptr, ptr %3, align 8
  %107 = getelementptr inbounds %struct.frameStruct_SQ, ptr %106, i32 0, i32 5
  %108 = load i64, ptr %107, align 8
  %109 = inttoptr i64 %108 to ptr
  call void @Cfree_SQ(ptr noundef %109)
  store ptr null, ptr %5, align 8
  br label %112

110:                                              ; preds = %52, %44, %41
  %111 = load ptr, ptr %3, align 8
  store ptr %111, ptr %5, align 8
  br label %112

112:                                              ; preds = %110, %105
  %113 = load ptr, ptr %3, align 8
  %114 = getelementptr inbounds %struct.frameStruct_SQ, ptr %113, i32 0, i32 1
  %115 = load i8, ptr %114, align 4
  %116 = zext i8 %115 to i32
  %117 = and i32 %116, -49
  %118 = or i32 %117, 0
  %119 = trunc i32 %118 to i8
  %120 = load ptr, ptr %3, align 8
  %121 = getelementptr inbounds %struct.frameStruct_SQ, ptr %120, i32 0, i32 1
  store i8 %119, ptr %121, align 4
  %122 = load ptr, ptr %3, align 8
  %123 = getelementptr inbounds %struct.frameStruct_SQ, ptr %122, i32 0, i32 2
  %124 = load i8, ptr %123, align 1
  %125 = zext i8 %124 to i32
  %126 = and i32 %125, -17
  %127 = trunc i32 %126 to i8
  store i8 %127, ptr %123, align 1
  %128 = load ptr, ptr %3, align 8
  %129 = getelementptr inbounds %struct.frameStruct_SQ, ptr %128, i32 0, i32 5
  store i64 0, ptr %129, align 8
  %130 = load ptr, ptr %5, align 8
  store ptr %130, ptr %2, align 8
  br label %131

131:                                              ; preds = %112, %39
  %132 = load ptr, ptr %2, align 8
  ret ptr %132
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @Cfree_SQ(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  %3 = alloca i64, align 8
  %4 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %5 = load ptr, ptr %2, align 8
  store ptr %5, ptr %4, align 8
  %6 = load ptr, ptr %4, align 8
  %7 = icmp ne ptr %6, null
  br i1 %7, label %8, label %23

8:                                                ; preds = %1
  %9 = load ptr, ptr %4, align 8
  %10 = getelementptr inbounds i8, ptr %9, i64 -4
  %11 = load i32, ptr %10, align 4
  %12 = zext i32 %11 to i64
  store i64 %12, ptr %3, align 8
  %13 = load i64, ptr %3, align 8
  %14 = load i64, ptr @totalBytes_SQ, align 8
  %15 = sub i64 %14, %13
  store i64 %15, ptr @totalBytes_SQ, align 8
  %16 = load ptr, ptr %4, align 8
  %17 = getelementptr inbounds i8, ptr %16, i64 -4
  call void @free(ptr noundef %17) #8
  %18 = load i64, ptr @totalBytes_SQ, align 8
  %19 = load i64, ptr %3, align 8
  %20 = load ptr, ptr %4, align 8
  %21 = getelementptr inbounds i8, ptr %20, i64 -4
  %22 = call i32 (ptr, ...) @printf(ptr noundef @.str.3, i64 noundef %18, i64 noundef %19, ptr noundef %21)
  br label %23

23:                                               ; preds = %8, %1
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local ptr @PutStringDAF_SQ(ptr noundef %0, ptr noundef %1) #0 {
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  %6 = alloca i16, align 2
  store ptr %0, ptr %4, align 8
  store ptr %1, ptr %5, align 8
  %7 = load ptr, ptr %5, align 8
  %8 = call i64 @strlen(ptr noundef %7) #9
  %9 = add i64 %8, 1
  %10 = trunc i64 %9 to i16
  store i16 %10, ptr %6, align 2
  %11 = load ptr, ptr %4, align 8
  %12 = icmp ne ptr %11, null
  br i1 %12, label %13, label %72

13:                                               ; preds = %2
  %14 = load ptr, ptr %4, align 8
  %15 = getelementptr inbounds %struct.frameStruct_SQ, ptr %14, i32 0, i32 1
  %16 = load i8, ptr %15, align 4
  %17 = zext i8 %16 to i32
  %18 = and i32 %17, -16
  %19 = or i32 %18, 4
  %20 = trunc i32 %19 to i8
  %21 = load ptr, ptr %4, align 8
  %22 = getelementptr inbounds %struct.frameStruct_SQ, ptr %21, i32 0, i32 1
  store i8 %20, ptr %22, align 4
  %23 = load ptr, ptr %4, align 8
  %24 = load i16, ptr %6, align 2
  %25 = call ptr @CreateDAF_SQ(ptr noundef %23, i16 noundef signext %24)
  %26 = icmp eq ptr %25, null
  br i1 %26, label %27, label %28

27:                                               ; preds = %13
  store ptr null, ptr %3, align 8
  br label %74

28:                                               ; preds = %13
  %29 = load ptr, ptr %4, align 8
  %30 = icmp ne ptr %29, null
  br i1 %30, label %31, label %65

31:                                               ; preds = %28
  %32 = load ptr, ptr %4, align 8
  %33 = icmp ne ptr %32, null
  br i1 %33, label %34, label %65

34:                                               ; preds = %31
  %35 = load ptr, ptr %4, align 8
  %36 = getelementptr inbounds %struct.frameStruct_SQ, ptr %35, i32 0, i32 1
  %37 = load i8, ptr %36, align 4
  %38 = zext i8 %37 to i32
  %39 = and i32 %38, 48
  %40 = icmp eq i32 %39, 16
  br i1 %40, label %41, label %65

41:                                               ; preds = %34
  %42 = load ptr, ptr %4, align 8
  %43 = icmp ne ptr %42, null
  br i1 %43, label %44, label %49

44:                                               ; preds = %41
  %45 = load ptr, ptr %4, align 8
  %46 = getelementptr inbounds %struct.frameStruct_SQ, ptr %45, i32 0, i32 5
  %47 = load i64, ptr %46, align 8
  %48 = icmp eq i64 %47, 0
  br i1 %48, label %65, label %49

49:                                               ; preds = %44, %41
  %50 = load ptr, ptr %4, align 8
  %51 = getelementptr inbounds %struct.frameStruct_SQ, ptr %50, i32 0, i32 5
  %52 = load i64, ptr %51, align 8
  %53 = inttoptr i64 %52 to ptr
  %54 = getelementptr inbounds %struct.dafHdrStruct_SQ, ptr %53, i32 0, i32 2
  %55 = load i16, ptr %54, align 2
  %56 = sext i16 %55 to i32
  %57 = icmp ne i32 %56, 0
  br i1 %57, label %58, label %65

58:                                               ; preds = %49
  %59 = load ptr, ptr %4, align 8
  %60 = getelementptr inbounds %struct.frameStruct_SQ, ptr %59, i32 0, i32 5
  %61 = load i64, ptr %60, align 8
  %62 = inttoptr i64 %61 to ptr
  %63 = getelementptr inbounds %struct.dafHdrStruct_SQ, ptr %62, i32 0, i32 0
  %64 = load ptr, ptr %63, align 8
  br label %66

65:                                               ; preds = %49, %44, %34, %31, %28
  br label %66

66:                                               ; preds = %65, %58
  %67 = phi ptr [ %64, %58 ], [ null, %65 ]
  %68 = load ptr, ptr %5, align 8
  %69 = load i16, ptr %6, align 2
  %70 = sext i16 %69 to i64
  %71 = call ptr @strncpy(ptr noundef %67, ptr noundef %68, i64 noundef %70) #8
  br label %72

72:                                               ; preds = %66, %2
  %73 = load ptr, ptr %4, align 8
  store ptr %73, ptr %3, align 8
  br label %74

74:                                               ; preds = %72, %27
  %75 = load ptr, ptr %3, align 8
  ret ptr %75
}

; Function Attrs: nounwind willreturn memory(read)
declare i64 @strlen(ptr noundef) #4

; Function Attrs: nounwind
declare ptr @strncpy(ptr noundef, ptr noundef, i64 noundef) #5

; Function Attrs: noinline nounwind optnone uwtable
define dso_local ptr @AddElement_SQ(ptr noundef %0, i16 noundef signext %1, ptr noundef %2) #0 {
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  %6 = alloca i16, align 2
  %7 = alloca ptr, align 8
  %8 = alloca i16, align 2
  %9 = alloca i16, align 2
  %10 = alloca i16, align 2
  %11 = alloca ptr, align 8
  %12 = alloca ptr, align 8
  %13 = alloca ptr, align 8
  %14 = alloca i32, align 4
  store ptr %0, ptr %5, align 8
  store i16 %1, ptr %6, align 2
  store ptr %2, ptr %7, align 8
  %15 = load ptr, ptr %5, align 8
  %16 = icmp eq ptr %15, null
  br i1 %16, label %24, label %17

17:                                               ; preds = %3
  %18 = load ptr, ptr %5, align 8
  %19 = getelementptr inbounds %struct.frameStruct_SQ, ptr %18, i32 0, i32 1
  %20 = load i8, ptr %19, align 4
  %21 = zext i8 %20 to i32
  %22 = and i32 %21, 15
  %23 = icmp sgt i32 %22, 11
  br i1 %23, label %24, label %25

24:                                               ; preds = %17, %3
  store ptr null, ptr %4, align 8
  br label %324

25:                                               ; preds = %17
  %26 = load ptr, ptr %5, align 8
  %27 = icmp ne ptr %26, null
  br i1 %27, label %28, label %35

28:                                               ; preds = %25
  %29 = load ptr, ptr %5, align 8
  %30 = getelementptr inbounds %struct.frameStruct_SQ, ptr %29, i32 0, i32 1
  %31 = load i8, ptr %30, align 4
  %32 = zext i8 %31 to i32
  %33 = and i32 %32, 48
  %34 = icmp eq i32 %33, 0
  br i1 %34, label %43, label %35

35:                                               ; preds = %28, %25
  %36 = load ptr, ptr %5, align 8
  %37 = icmp ne ptr %36, null
  br i1 %37, label %38, label %46

38:                                               ; preds = %35
  %39 = load ptr, ptr %5, align 8
  %40 = getelementptr inbounds %struct.frameStruct_SQ, ptr %39, i32 0, i32 5
  %41 = load i64, ptr %40, align 8
  %42 = icmp eq i64 %41, 0
  br i1 %42, label %43, label %46

43:                                               ; preds = %38, %28
  %44 = load ptr, ptr %5, align 8
  %45 = call ptr @CreateDAF_SQ(ptr noundef %44, i16 noundef signext 0)
  store ptr %45, ptr %5, align 8
  br label %46

46:                                               ; preds = %43, %38, %35
  %47 = load ptr, ptr %5, align 8
  %48 = getelementptr inbounds %struct.frameStruct_SQ, ptr %47, i32 0, i32 1
  %49 = load i8, ptr %48, align 4
  %50 = zext i8 %49 to i32
  %51 = and i32 %50, 15
  %52 = sext i32 %51 to i64
  %53 = getelementptr inbounds [12 x i8], ptr @typeSize_SQ, i64 0, i64 %52
  %54 = load i8, ptr %53, align 1
  %55 = zext i8 %54 to i16
  store i16 %55, ptr %8, align 2
  %56 = load i16, ptr %6, align 2
  %57 = sext i16 %56 to i32
  %58 = load i16, ptr %8, align 2
  %59 = sext i16 %58 to i32
  %60 = mul nsw i32 %57, %59
  %61 = trunc i32 %60 to i16
  store i16 %61, ptr %10, align 2
  %62 = load i16, ptr %10, align 2
  %63 = sext i16 %62 to i32
  %64 = icmp slt i32 %63, 0
  br i1 %64, label %65, label %66

65:                                               ; preds = %46
  store ptr null, ptr %4, align 8
  br label %324

66:                                               ; preds = %46
  %67 = load ptr, ptr %5, align 8
  %68 = icmp ne ptr %67, null
  br i1 %68, label %69, label %95

69:                                               ; preds = %66
  %70 = load ptr, ptr %5, align 8
  %71 = icmp ne ptr %70, null
  br i1 %71, label %72, label %95

72:                                               ; preds = %69
  %73 = load ptr, ptr %5, align 8
  %74 = getelementptr inbounds %struct.frameStruct_SQ, ptr %73, i32 0, i32 1
  %75 = load i8, ptr %74, align 4
  %76 = zext i8 %75 to i32
  %77 = and i32 %76, 48
  %78 = icmp eq i32 %77, 16
  br i1 %78, label %79, label %95

79:                                               ; preds = %72
  %80 = load ptr, ptr %5, align 8
  %81 = icmp ne ptr %80, null
  br i1 %81, label %82, label %87

82:                                               ; preds = %79
  %83 = load ptr, ptr %5, align 8
  %84 = getelementptr inbounds %struct.frameStruct_SQ, ptr %83, i32 0, i32 5
  %85 = load i64, ptr %84, align 8
  %86 = icmp eq i64 %85, 0
  br i1 %86, label %95, label %87

87:                                               ; preds = %82, %79
  %88 = load ptr, ptr %5, align 8
  %89 = getelementptr inbounds %struct.frameStruct_SQ, ptr %88, i32 0, i32 5
  %90 = load i64, ptr %89, align 8
  %91 = inttoptr i64 %90 to ptr
  %92 = getelementptr inbounds %struct.dafHdrStruct_SQ, ptr %91, i32 0, i32 2
  %93 = load i16, ptr %92, align 2
  %94 = sext i16 %93 to i32
  br label %96

95:                                               ; preds = %82, %72, %69, %66
  br label %96

96:                                               ; preds = %95, %87
  %97 = phi i32 [ %94, %87 ], [ 0, %95 ]
  %98 = trunc i32 %97 to i16
  store i16 %98, ptr %9, align 2
  %99 = load i16, ptr %9, align 2
  %100 = sext i16 %99 to i32
  %101 = add nsw i32 %100, 1
  %102 = icmp slt i32 %101, 0
  br i1 %102, label %103, label %104

103:                                              ; preds = %96
  store ptr null, ptr %4, align 8
  br label %324

104:                                              ; preds = %96
  %105 = load ptr, ptr %5, align 8
  %106 = getelementptr inbounds %struct.frameStruct_SQ, ptr %105, i32 0, i32 5
  %107 = load i64, ptr %106, align 8
  %108 = inttoptr i64 %107 to ptr
  %109 = getelementptr inbounds %struct.dafHdrStruct_SQ, ptr %108, i32 0, i32 0
  %110 = load ptr, ptr %109, align 8
  store ptr %110, ptr %12, align 8
  %111 = icmp eq ptr %110, null
  br i1 %111, label %112, label %118

112:                                              ; preds = %104
  %113 = load ptr, ptr %5, align 8
  %114 = getelementptr inbounds %struct.frameStruct_SQ, ptr %113, i32 0, i32 5
  %115 = load i64, ptr %114, align 8
  %116 = inttoptr i64 %115 to ptr
  %117 = getelementptr inbounds %struct.dafHdrStruct_SQ, ptr %116, i32 0, i32 2
  store i16 0, ptr %117, align 2
  store i32 0, ptr %14, align 4
  br label %128

118:                                              ; preds = %104
  %119 = load ptr, ptr %12, align 8
  %120 = getelementptr inbounds i8, ptr %119, i64 -4
  %121 = load i32, ptr %120, align 4
  %122 = zext i32 %121 to i64
  %123 = sub i64 %122, 4
  %124 = load i16, ptr %8, align 2
  %125 = sext i16 %124 to i64
  %126 = udiv i64 %123, %125
  %127 = trunc i64 %126 to i32
  store i32 %127, ptr %14, align 4
  br label %128

128:                                              ; preds = %118, %112
  %129 = load i32, ptr %14, align 4
  %130 = load i16, ptr %9, align 2
  %131 = sext i16 %130 to i32
  %132 = icmp ugt i32 %129, %131
  br i1 %132, label %133, label %169

133:                                              ; preds = %128
  %134 = load ptr, ptr %12, align 8
  store ptr %134, ptr %11, align 8
  %135 = load i16, ptr %6, align 2
  %136 = sext i16 %135 to i32
  %137 = icmp sge i32 %136, 0
  br i1 %137, label %138, label %168

138:                                              ; preds = %133
  %139 = load i16, ptr %6, align 2
  %140 = sext i16 %139 to i32
  %141 = load i16, ptr %9, align 2
  %142 = sext i16 %141 to i32
  %143 = icmp sle i32 %140, %142
  br i1 %143, label %144, label %168

144:                                              ; preds = %138
  %145 = load ptr, ptr %11, align 8
  %146 = load i16, ptr %10, align 2
  %147 = sext i16 %146 to i32
  %148 = sext i32 %147 to i64
  %149 = getelementptr inbounds i8, ptr %145, i64 %148
  %150 = load i16, ptr %8, align 2
  %151 = sext i16 %150 to i32
  %152 = sext i32 %151 to i64
  %153 = getelementptr inbounds i8, ptr %149, i64 %152
  %154 = load ptr, ptr %11, align 8
  %155 = load i16, ptr %10, align 2
  %156 = sext i16 %155 to i32
  %157 = sext i32 %156 to i64
  %158 = getelementptr inbounds i8, ptr %154, i64 %157
  %159 = load i16, ptr %9, align 2
  %160 = sext i16 %159 to i32
  %161 = load i16, ptr %6, align 2
  %162 = sext i16 %161 to i32
  %163 = sub nsw i32 %160, %162
  %164 = load i16, ptr %8, align 2
  %165 = sext i16 %164 to i32
  %166 = mul nsw i32 %163, %165
  %167 = sext i32 %166 to i64
  call void @llvm.memmove.p0.p0.i64(ptr align 1 %153, ptr align 1 %158, i64 %167, i1 false)
  br label %168

168:                                              ; preds = %144, %138, %133
  br label %232

169:                                              ; preds = %128
  %170 = load i32, ptr %14, align 4
  %171 = add i32 %170, 4
  %172 = load i16, ptr %8, align 2
  %173 = sext i16 %172 to i32
  %174 = call ptr @Calloc_SQ(i32 noundef %171, i32 noundef %173)
  store ptr %174, ptr %11, align 8
  %175 = icmp eq ptr %174, null
  br i1 %175, label %176, label %177

176:                                              ; preds = %169
  store ptr null, ptr %4, align 8
  br label %324

177:                                              ; preds = %169
  %178 = load i16, ptr %6, align 2
  %179 = sext i16 %178 to i32
  %180 = icmp sge i32 %179, 0
  br i1 %180, label %181, label %215

181:                                              ; preds = %177
  %182 = load i16, ptr %6, align 2
  %183 = sext i16 %182 to i32
  %184 = load i16, ptr %9, align 2
  %185 = sext i16 %184 to i32
  %186 = icmp sle i32 %183, %185
  br i1 %186, label %187, label %215

187:                                              ; preds = %181
  %188 = load ptr, ptr %11, align 8
  %189 = load ptr, ptr %12, align 8
  %190 = load i16, ptr %10, align 2
  %191 = sext i16 %190 to i64
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %188, ptr align 1 %189, i64 %191, i1 false)
  %192 = load ptr, ptr %11, align 8
  %193 = load i16, ptr %10, align 2
  %194 = sext i16 %193 to i32
  %195 = sext i32 %194 to i64
  %196 = getelementptr inbounds i8, ptr %192, i64 %195
  %197 = load i16, ptr %8, align 2
  %198 = sext i16 %197 to i32
  %199 = sext i32 %198 to i64
  %200 = getelementptr inbounds i8, ptr %196, i64 %199
  %201 = load ptr, ptr %12, align 8
  %202 = load i16, ptr %10, align 2
  %203 = sext i16 %202 to i32
  %204 = sext i32 %203 to i64
  %205 = getelementptr inbounds i8, ptr %201, i64 %204
  %206 = load i16, ptr %9, align 2
  %207 = sext i16 %206 to i32
  %208 = load i16, ptr %6, align 2
  %209 = sext i16 %208 to i32
  %210 = sub nsw i32 %207, %209
  %211 = load i16, ptr %8, align 2
  %212 = sext i16 %211 to i32
  %213 = mul nsw i32 %210, %212
  %214 = sext i32 %213 to i64
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %200, ptr align 1 %205, i64 %214, i1 false)
  br label %215

215:                                              ; preds = %187, %181, %177
  %216 = load ptr, ptr %5, align 8
  %217 = icmp ne ptr %216, null
  br i1 %217, label %218, label %231

218:                                              ; preds = %215
  %219 = load ptr, ptr %5, align 8
  %220 = getelementptr inbounds %struct.frameStruct_SQ, ptr %219, i32 0, i32 2
  %221 = load i8, ptr %220, align 1
  %222 = zext i8 %221 to i32
  %223 = and i32 %222, 240
  %224 = and i32 %223, 16
  %225 = icmp ne i32 %224, 0
  br i1 %225, label %226, label %231

226:                                              ; preds = %218
  %227 = load ptr, ptr %12, align 8
  %228 = icmp ne ptr %227, null
  br i1 %228, label %229, label %231

229:                                              ; preds = %226
  %230 = load ptr, ptr %12, align 8
  call void @Cfree_SQ(ptr noundef %230)
  br label %231

231:                                              ; preds = %229, %226, %218, %215
  br label %232

232:                                              ; preds = %231, %168
  %233 = load ptr, ptr %7, align 8
  %234 = icmp eq ptr %233, null
  br i1 %234, label %235, label %243

235:                                              ; preds = %232
  %236 = load ptr, ptr %11, align 8
  %237 = load i16, ptr %10, align 2
  %238 = sext i16 %237 to i32
  %239 = sext i32 %238 to i64
  %240 = getelementptr inbounds i8, ptr %236, i64 %239
  %241 = load i16, ptr %8, align 2
  %242 = sext i16 %241 to i64
  call void @llvm.memset.p0.i64(ptr align 1 %240, i8 0, i64 %242, i1 false)
  br label %252

243:                                              ; preds = %232
  %244 = load ptr, ptr %11, align 8
  %245 = load i16, ptr %10, align 2
  %246 = sext i16 %245 to i32
  %247 = sext i32 %246 to i64
  %248 = getelementptr inbounds i8, ptr %244, i64 %247
  %249 = load ptr, ptr %7, align 8
  %250 = load i16, ptr %8, align 2
  %251 = sext i16 %250 to i64
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %248, ptr align 1 %249, i64 %251, i1 false)
  br label %252

252:                                              ; preds = %243, %235
  %253 = load ptr, ptr %5, align 8
  %254 = icmp ne ptr %253, null
  br i1 %254, label %255, label %305

255:                                              ; preds = %252
  %256 = load ptr, ptr %5, align 8
  %257 = getelementptr inbounds %struct.frameStruct_SQ, ptr %256, i32 0, i32 1
  %258 = load i8, ptr %257, align 4
  %259 = zext i8 %258 to i32
  %260 = and i32 %259, 15
  %261 = icmp eq i32 %260, 9
  br i1 %261, label %262, label %305

262:                                              ; preds = %255
  %263 = load ptr, ptr %7, align 8
  %264 = icmp ne ptr %263, null
  br i1 %264, label %265, label %305

265:                                              ; preds = %262
  %266 = load ptr, ptr %7, align 8
  %267 = icmp ne ptr %266, null
  br i1 %267, label %268, label %275

268:                                              ; preds = %265
  %269 = load ptr, ptr %7, align 8
  %270 = getelementptr inbounds %struct.frameStruct_SQ, ptr %269, i32 0, i32 1
  %271 = load i8, ptr %270, align 4
  %272 = zext i8 %271 to i32
  %273 = and i32 %272, 48
  %274 = icmp eq i32 %273, 16
  br i1 %274, label %285, label %275

275:                                              ; preds = %268, %265
  %276 = load ptr, ptr %7, align 8
  %277 = icmp ne ptr %276, null
  br i1 %277, label %278, label %305

278:                                              ; preds = %275
  %279 = load ptr, ptr %7, align 8
  %280 = getelementptr inbounds %struct.frameStruct_SQ, ptr %279, i32 0, i32 1
  %281 = load i8, ptr %280, align 4
  %282 = zext i8 %281 to i32
  %283 = and i32 %282, 48
  %284 = icmp eq i32 %283, 32
  br i1 %284, label %285, label %305

285:                                              ; preds = %278, %268
  %286 = load ptr, ptr %7, align 8
  %287 = getelementptr inbounds %struct.frameStruct_SQ, ptr %286, i32 0, i32 5
  %288 = load i64, ptr %287, align 8
  %289 = icmp ne i64 %288, 0
  br i1 %289, label %290, label %305

290:                                              ; preds = %285
  %291 = load ptr, ptr %7, align 8
  %292 = getelementptr inbounds %struct.frameStruct_SQ, ptr %291, i32 0, i32 5
  %293 = load i64, ptr %292, align 8
  %294 = inttoptr i64 %293 to ptr
  %295 = getelementptr inbounds %struct.dafHdrStruct_SQ, ptr %294, i32 0, i32 1
  %296 = load i16, ptr %295, align 8
  %297 = sext i16 %296 to i32
  %298 = add nsw i32 %297, 1
  %299 = trunc i32 %298 to i16
  %300 = load ptr, ptr %7, align 8
  %301 = getelementptr inbounds %struct.frameStruct_SQ, ptr %300, i32 0, i32 5
  %302 = load i64, ptr %301, align 8
  %303 = inttoptr i64 %302 to ptr
  %304 = getelementptr inbounds %struct.dafHdrStruct_SQ, ptr %303, i32 0, i32 1
  store i16 %299, ptr %304, align 8
  br label %305

305:                                              ; preds = %290, %285, %278, %275, %262, %255, %252
  %306 = load ptr, ptr %5, align 8
  %307 = getelementptr inbounds %struct.frameStruct_SQ, ptr %306, i32 0, i32 5
  %308 = load i64, ptr %307, align 8
  %309 = inttoptr i64 %308 to ptr
  store ptr %309, ptr %13, align 8
  %310 = load i16, ptr %9, align 2
  %311 = sext i16 %310 to i32
  %312 = add nsw i32 %311, 1
  %313 = trunc i32 %312 to i16
  %314 = load ptr, ptr %13, align 8
  %315 = getelementptr inbounds %struct.dafHdrStruct_SQ, ptr %314, i32 0, i32 2
  store i16 %313, ptr %315, align 2
  %316 = load ptr, ptr %11, align 8
  %317 = load ptr, ptr %13, align 8
  %318 = getelementptr inbounds %struct.dafHdrStruct_SQ, ptr %317, i32 0, i32 0
  store ptr %316, ptr %318, align 8
  %319 = load ptr, ptr %11, align 8
  %320 = load i16, ptr %10, align 2
  %321 = sext i16 %320 to i32
  %322 = sext i32 %321 to i64
  %323 = getelementptr inbounds i8, ptr %319, i64 %322
  store ptr %323, ptr %4, align 8
  br label %324

324:                                              ; preds = %305, %176, %103, %65, %24
  %325 = load ptr, ptr %4, align 8
  ret ptr %325
}

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memmove.p0.p0.i64(ptr nocapture writeonly, ptr nocapture readonly, i64, i1 immarg) #6

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p0.p0.i64(ptr noalias nocapture writeonly, ptr noalias nocapture readonly, i64, i1 immarg) #6

; Function Attrs: nounwind
declare void @free(ptr noundef) #5

; Function Attrs: noinline nounwind optnone uwtable
define dso_local ptr @DeleteFrame_SQ(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  %3 = alloca ptr, align 8
  store ptr %0, ptr %3, align 8
  %4 = load ptr, ptr %3, align 8
  %5 = icmp eq ptr %4, null
  br i1 %5, label %6, label %7

6:                                                ; preds = %1
  store ptr null, ptr %2, align 8
  br label %40

7:                                                ; preds = %1
  %8 = load ptr, ptr %3, align 8
  %9 = icmp ne ptr %8, null
  br i1 %9, label %10, label %38

10:                                               ; preds = %7
  %11 = load ptr, ptr %3, align 8
  %12 = icmp ne ptr %11, null
  br i1 %12, label %13, label %20

13:                                               ; preds = %10
  %14 = load ptr, ptr %3, align 8
  %15 = getelementptr inbounds %struct.frameStruct_SQ, ptr %14, i32 0, i32 1
  %16 = load i8, ptr %15, align 4
  %17 = zext i8 %16 to i32
  %18 = and i32 %17, 48
  %19 = icmp eq i32 %18, 16
  br i1 %19, label %30, label %20

20:                                               ; preds = %13, %10
  %21 = load ptr, ptr %3, align 8
  %22 = icmp ne ptr %21, null
  br i1 %22, label %23, label %38

23:                                               ; preds = %20
  %24 = load ptr, ptr %3, align 8
  %25 = getelementptr inbounds %struct.frameStruct_SQ, ptr %24, i32 0, i32 1
  %26 = load i8, ptr %25, align 4
  %27 = zext i8 %26 to i32
  %28 = and i32 %27, 48
  %29 = icmp eq i32 %28, 32
  br i1 %29, label %30, label %38

30:                                               ; preds = %23, %13
  %31 = load ptr, ptr %3, align 8
  %32 = getelementptr inbounds %struct.frameStruct_SQ, ptr %31, i32 0, i32 5
  %33 = load i64, ptr %32, align 8
  %34 = icmp ne i64 %33, 0
  br i1 %34, label %35, label %38

35:                                               ; preds = %30
  %36 = load ptr, ptr %3, align 8
  %37 = call ptr @DeleteDAF_SQ(ptr noundef %36)
  br label %38

38:                                               ; preds = %35, %30, %23, %20, %7
  %39 = load ptr, ptr %3, align 8
  call void @Cfree_SQ(ptr noundef %39)
  store ptr null, ptr %2, align 8
  br label %40

40:                                               ; preds = %38, %6
  %41 = load ptr, ptr %2, align 8
  ret ptr %41
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @MemoryLeak1() #0 {
  %1 = alloca i32, align 4
  %2 = alloca ptr, align 8
  %3 = alloca i64, align 8
  store ptr null, ptr %2, align 8
  store i64 2, ptr %3, align 8
  %4 = load i64, ptr @totalBytes_SQ, align 8
  %5 = call i32 (ptr, ...) @printf(ptr noundef @.str.4, i64 noundef %4)
  %6 = call ptr @CreateFrame_SQ()
  store ptr %6, ptr %2, align 8
  %7 = icmp ne ptr %6, null
  br i1 %7, label %9, label %8

8:                                                ; preds = %0
  store i32 0, ptr %1, align 4
  br label %26

9:                                                ; preds = %0
  %10 = load i64, ptr @.str.5, align 1
  %11 = load ptr, ptr %2, align 8
  store i64 %10, ptr %11, align 8
  %12 = load ptr, ptr %2, align 8
  %13 = getelementptr inbounds %struct.frameStruct_SQ, ptr %12, i32 0, i32 1
  %14 = load i8, ptr %13, align 4
  %15 = zext i8 %14 to i32
  %16 = and i32 %15, -16
  %17 = or i32 %16, 0
  %18 = trunc i32 %17 to i8
  %19 = load ptr, ptr %2, align 8
  %20 = getelementptr inbounds %struct.frameStruct_SQ, ptr %19, i32 0, i32 1
  store i8 %18, ptr %20, align 4
  %21 = load i64, ptr %3, align 8
  %22 = load ptr, ptr %2, align 8
  %23 = getelementptr inbounds %struct.frameStruct_SQ, ptr %22, i32 0, i32 5
  store i64 %21, ptr %23, align 8
  %24 = load i64, ptr @totalBytes_SQ, align 8
  %25 = call i32 (ptr, ...) @printf(ptr noundef @.str.6, i64 noundef %24)
  store i32 1, ptr %1, align 4
  br label %26

26:                                               ; preds = %9, %8
  %27 = load i32, ptr %1, align 4
  ret i32 %27
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @MemoryLeak1_overflow() #0 {
  %1 = alloca i32, align 4
  %2 = alloca ptr, align 8
  %3 = alloca i64, align 8
  %4 = alloca [4 x i8], align 1
  store ptr null, ptr %2, align 8
  store i64 2, ptr %3, align 8
  call void @llvm.memset.p0.i64(ptr align 1 %4, i8 0, i64 4, i1 false)
  %5 = load i64, ptr @totalBytes_SQ, align 8
  %6 = call i32 (ptr, ...) @printf(ptr noundef @.str.7, i64 noundef %5)
  %7 = call ptr @CreateFrame_SQ()
  store ptr %7, ptr %2, align 8
  %8 = icmp ne ptr %7, null
  br i1 %8, label %10, label %9

9:                                                ; preds = %0
  store i32 0, ptr %1, align 4
  br label %29

10:                                               ; preds = %0
  %11 = load i64, ptr @.str.5, align 1
  %12 = load ptr, ptr %2, align 8
  store i64 %11, ptr %12, align 8
  %13 = load ptr, ptr %2, align 8
  %14 = getelementptr inbounds %struct.frameStruct_SQ, ptr %13, i32 0, i32 1
  %15 = load i8, ptr %14, align 4
  %16 = zext i8 %15 to i32
  %17 = and i32 %16, -16
  %18 = or i32 %17, 0
  %19 = trunc i32 %18 to i8
  %20 = load ptr, ptr %2, align 8
  %21 = getelementptr inbounds %struct.frameStruct_SQ, ptr %20, i32 0, i32 1
  store i8 %19, ptr %21, align 4
  %22 = load i64, ptr %3, align 8
  %23 = load ptr, ptr %2, align 8
  %24 = getelementptr inbounds %struct.frameStruct_SQ, ptr %23, i32 0, i32 5
  store i64 %22, ptr %24, align 8
  %25 = load i64, ptr @totalBytes_SQ, align 8
  %26 = call i32 (ptr, ...) @printf(ptr noundef @.str.8, i64 noundef %25)
  %27 = getelementptr inbounds [4 x i8], ptr %4, i64 0, i64 0
  %28 = call ptr @strcpy(ptr noundef %27, ptr noundef @.str.9) #8
  store i32 1, ptr %1, align 4
  br label %29

29:                                               ; preds = %10, %9
  %30 = load i32, ptr %1, align 4
  ret i32 %30
}

; Function Attrs: nounwind
declare ptr @strcpy(ptr noundef, ptr noundef) #5

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @NoMemoryLeak1() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i64, align 8
  store i64 2, ptr %2, align 8
  %3 = load i64, ptr @totalBytes_SQ, align 8
  %4 = call i32 (ptr, ...) @printf(ptr noundef @.str.10, i64 noundef %3)
  %5 = load ptr, ptr @NoMemoryLeak1.localFrm, align 8
  %6 = icmp eq ptr %5, null
  br i1 %6, label %7, label %12

7:                                                ; preds = %0
  %8 = call ptr @CreateFrame_SQ()
  store ptr %8, ptr @NoMemoryLeak1.localFrm, align 8
  %9 = icmp ne ptr %8, null
  br i1 %9, label %11, label %10

10:                                               ; preds = %7
  store i32 0, ptr %1, align 4
  br label %29

11:                                               ; preds = %7
  br label %12

12:                                               ; preds = %11, %0
  %13 = load i64, ptr @.str.5, align 1
  %14 = load ptr, ptr @NoMemoryLeak1.localFrm, align 8
  store i64 %13, ptr %14, align 8
  %15 = load ptr, ptr @NoMemoryLeak1.localFrm, align 8
  %16 = getelementptr inbounds %struct.frameStruct_SQ, ptr %15, i32 0, i32 1
  %17 = load i8, ptr %16, align 4
  %18 = zext i8 %17 to i32
  %19 = and i32 %18, -16
  %20 = or i32 %19, 0
  %21 = trunc i32 %20 to i8
  %22 = load ptr, ptr @NoMemoryLeak1.localFrm, align 8
  %23 = getelementptr inbounds %struct.frameStruct_SQ, ptr %22, i32 0, i32 1
  store i8 %21, ptr %23, align 4
  %24 = load i64, ptr %2, align 8
  %25 = load ptr, ptr @NoMemoryLeak1.localFrm, align 8
  %26 = getelementptr inbounds %struct.frameStruct_SQ, ptr %25, i32 0, i32 5
  store i64 %24, ptr %26, align 8
  %27 = load i64, ptr @totalBytes_SQ, align 8
  %28 = call i32 (ptr, ...) @printf(ptr noundef @.str.11, i64 noundef %27)
  store i32 1, ptr %1, align 4
  br label %29

29:                                               ; preds = %12, %10
  %30 = load i32, ptr %1, align 4
  ret i32 %30
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @NoMemoryLeak2() #0 {
  %1 = alloca i32, align 4
  %2 = alloca ptr, align 8
  %3 = alloca i64, align 8
  store ptr null, ptr %2, align 8
  store i64 2, ptr %3, align 8
  %4 = load i64, ptr @totalBytes_SQ, align 8
  %5 = call i32 (ptr, ...) @printf(ptr noundef @.str.12, i64 noundef %4)
  %6 = load ptr, ptr %2, align 8
  %7 = icmp eq ptr %6, null
  br i1 %7, label %8, label %13

8:                                                ; preds = %0
  %9 = call ptr @CreateFrame_SQ()
  store ptr %9, ptr %2, align 8
  %10 = icmp ne ptr %9, null
  br i1 %10, label %12, label %11

11:                                               ; preds = %8
  store i32 0, ptr %1, align 4
  br label %32

12:                                               ; preds = %8
  br label %13

13:                                               ; preds = %12, %0
  %14 = load i64, ptr @.str.5, align 1
  %15 = load ptr, ptr %2, align 8
  store i64 %14, ptr %15, align 8
  %16 = load ptr, ptr %2, align 8
  %17 = getelementptr inbounds %struct.frameStruct_SQ, ptr %16, i32 0, i32 1
  %18 = load i8, ptr %17, align 4
  %19 = zext i8 %18 to i32
  %20 = and i32 %19, -16
  %21 = or i32 %20, 0
  %22 = trunc i32 %21 to i8
  %23 = load ptr, ptr %2, align 8
  %24 = getelementptr inbounds %struct.frameStruct_SQ, ptr %23, i32 0, i32 1
  store i8 %22, ptr %24, align 4
  %25 = load i64, ptr %3, align 8
  %26 = load ptr, ptr %2, align 8
  %27 = getelementptr inbounds %struct.frameStruct_SQ, ptr %26, i32 0, i32 5
  store i64 %25, ptr %27, align 8
  %28 = load ptr, ptr %2, align 8
  %29 = call ptr @DeleteFrame_SQ(ptr noundef %28)
  %30 = load i64, ptr @totalBytes_SQ, align 8
  %31 = call i32 (ptr, ...) @printf(ptr noundef @.str.13, i64 noundef %30)
  store i32 1, ptr %1, align 4
  br label %32

32:                                               ; preds = %13, %11
  %33 = load i32, ptr %1, align 4
  ret i32 %33
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @MemoryLeak2() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i64, align 8
  store i64 2, ptr %2, align 8
  %3 = load i64, ptr @totalBytes_SQ, align 8
  %4 = call i32 (ptr, ...) @printf(ptr noundef @.str.14, i64 noundef %3)
  %5 = load ptr, ptr @MemoryLeak2.localFrm, align 8
  %6 = icmp eq ptr %5, null
  br i1 %6, label %7, label %12

7:                                                ; preds = %0
  %8 = call ptr @CreateFrame_SQ()
  store ptr %8, ptr @MemoryLeak2.localFrm, align 8
  %9 = icmp ne ptr %8, null
  br i1 %9, label %11, label %10

10:                                               ; preds = %7
  store i32 0, ptr %1, align 4
  br label %30

11:                                               ; preds = %7
  br label %12

12:                                               ; preds = %11, %0
  %13 = load i64, ptr @.str.5, align 1
  %14 = load ptr, ptr @MemoryLeak2.localFrm, align 8
  store i64 %13, ptr %14, align 8
  %15 = load ptr, ptr @MemoryLeak2.localFrm, align 8
  %16 = getelementptr inbounds %struct.frameStruct_SQ, ptr %15, i32 0, i32 1
  %17 = load i8, ptr %16, align 4
  %18 = zext i8 %17 to i32
  %19 = and i32 %18, -16
  %20 = or i32 %19, 0
  %21 = trunc i32 %20 to i8
  %22 = load ptr, ptr @MemoryLeak2.localFrm, align 8
  %23 = getelementptr inbounds %struct.frameStruct_SQ, ptr %22, i32 0, i32 1
  store i8 %21, ptr %23, align 4
  %24 = load i64, ptr %2, align 8
  %25 = load ptr, ptr @MemoryLeak2.localFrm, align 8
  %26 = getelementptr inbounds %struct.frameStruct_SQ, ptr %25, i32 0, i32 5
  store i64 %24, ptr %26, align 8
  %27 = call ptr @CreateFrame_SQ()
  store ptr %27, ptr @MemoryLeak2.localFrm, align 8
  %28 = load i64, ptr @totalBytes_SQ, align 8
  %29 = call i32 (ptr, ...) @printf(ptr noundef @.str.15, i64 noundef %28)
  store i32 1, ptr %1, align 4
  br label %30

30:                                               ; preds = %12, %10
  %31 = load i32, ptr %1, align 4
  ret i32 %31
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @MemoryLeak2_overflow() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i64, align 8
  %3 = alloca [4 x i8], align 1
  store i64 2, ptr %2, align 8
  call void @llvm.memset.p0.i64(ptr align 1 %3, i8 0, i64 4, i1 false)
  %4 = load i64, ptr @totalBytes_SQ, align 8
  %5 = call i32 (ptr, ...) @printf(ptr noundef @.str.16, i64 noundef %4)
  %6 = load ptr, ptr @MemoryLeak2_overflow.localFrm, align 8
  %7 = icmp eq ptr %6, null
  br i1 %7, label %8, label %13

8:                                                ; preds = %0
  %9 = call ptr @CreateFrame_SQ()
  store ptr %9, ptr @MemoryLeak2_overflow.localFrm, align 8
  %10 = icmp ne ptr %9, null
  br i1 %10, label %12, label %11

11:                                               ; preds = %8
  store i32 0, ptr %1, align 4
  br label %33

12:                                               ; preds = %8
  br label %13

13:                                               ; preds = %12, %0
  %14 = load i64, ptr @.str.5, align 1
  %15 = load ptr, ptr @MemoryLeak2_overflow.localFrm, align 8
  store i64 %14, ptr %15, align 8
  %16 = load ptr, ptr @MemoryLeak2_overflow.localFrm, align 8
  %17 = getelementptr inbounds %struct.frameStruct_SQ, ptr %16, i32 0, i32 1
  %18 = load i8, ptr %17, align 4
  %19 = zext i8 %18 to i32
  %20 = and i32 %19, -16
  %21 = or i32 %20, 0
  %22 = trunc i32 %21 to i8
  %23 = load ptr, ptr @MemoryLeak2_overflow.localFrm, align 8
  %24 = getelementptr inbounds %struct.frameStruct_SQ, ptr %23, i32 0, i32 1
  store i8 %22, ptr %24, align 4
  %25 = load i64, ptr %2, align 8
  %26 = load ptr, ptr @MemoryLeak2_overflow.localFrm, align 8
  %27 = getelementptr inbounds %struct.frameStruct_SQ, ptr %26, i32 0, i32 5
  store i64 %25, ptr %27, align 8
  %28 = call ptr @CreateFrame_SQ()
  store ptr %28, ptr @MemoryLeak2_overflow.localFrm, align 8
  %29 = load i64, ptr @totalBytes_SQ, align 8
  %30 = call i32 (ptr, ...) @printf(ptr noundef @.str.17, i64 noundef %29)
  %31 = getelementptr inbounds [4 x i8], ptr %3, i64 0, i64 0
  %32 = call ptr @strcpy(ptr noundef %31, ptr noundef @.str.9) #8
  store i32 1, ptr %1, align 4
  br label %33

33:                                               ; preds = %13, %11
  %34 = load i32, ptr %1, align 4
  ret i32 %34
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @MemoryLeak3() #0 {
  %1 = alloca i32, align 4
  %2 = load i64, ptr @totalBytes_SQ, align 8
  %3 = call i32 (ptr, ...) @printf(ptr noundef @.str.18, i64 noundef %2)
  %4 = load ptr, ptr @MemoryLeak3.localFrm, align 8
  %5 = icmp eq ptr %4, null
  br i1 %5, label %6, label %11

6:                                                ; preds = %0
  %7 = call ptr @CreateFrame_SQ()
  store ptr %7, ptr @MemoryLeak3.localFrm, align 8
  %8 = icmp ne ptr %7, null
  br i1 %8, label %10, label %9

9:                                                ; preds = %6
  store i32 0, ptr %1, align 4
  br label %66

10:                                               ; preds = %6
  br label %11

11:                                               ; preds = %10, %0
  %12 = load ptr, ptr @MemoryLeak3.localDAF, align 8
  %13 = icmp eq ptr %12, null
  br i1 %13, label %14, label %21

14:                                               ; preds = %11
  %15 = load ptr, ptr @MemoryLeak3.localDAF, align 8
  %16 = call ptr @CreateDAF_SQ(ptr noundef %15, i16 noundef signext 0)
  store ptr %16, ptr @MemoryLeak3.localDAF, align 8
  %17 = load ptr, ptr @MemoryLeak3.localDAF, align 8
  %18 = icmp eq ptr %17, null
  br i1 %18, label %19, label %20

19:                                               ; preds = %14
  store i32 0, ptr %1, align 4
  br label %66

20:                                               ; preds = %14
  br label %21

21:                                               ; preds = %20, %11
  %22 = load i64, ptr @.str.19, align 1
  %23 = load ptr, ptr @MemoryLeak3.localDAF, align 8
  store i64 %22, ptr %23, align 8
  %24 = load ptr, ptr @MemoryLeak3.localDAF, align 8
  %25 = icmp eq ptr %24, null
  br i1 %25, label %26, label %27

26:                                               ; preds = %21
  br label %62

27:                                               ; preds = %21
  %28 = load ptr, ptr @MemoryLeak3.localDAF, align 8
  %29 = load ptr, ptr @MemoryLeak3.localDAF, align 8
  %30 = icmp ne ptr %29, null
  br i1 %30, label %31, label %57

31:                                               ; preds = %27
  %32 = load ptr, ptr @MemoryLeak3.localDAF, align 8
  %33 = icmp ne ptr %32, null
  br i1 %33, label %34, label %57

34:                                               ; preds = %31
  %35 = load ptr, ptr @MemoryLeak3.localDAF, align 8
  %36 = getelementptr inbounds %struct.frameStruct_SQ, ptr %35, i32 0, i32 1
  %37 = load i8, ptr %36, align 4
  %38 = zext i8 %37 to i32
  %39 = and i32 %38, 48
  %40 = icmp eq i32 %39, 16
  br i1 %40, label %41, label %57

41:                                               ; preds = %34
  %42 = load ptr, ptr @MemoryLeak3.localDAF, align 8
  %43 = icmp ne ptr %42, null
  br i1 %43, label %44, label %49

44:                                               ; preds = %41
  %45 = load ptr, ptr @MemoryLeak3.localDAF, align 8
  %46 = getelementptr inbounds %struct.frameStruct_SQ, ptr %45, i32 0, i32 5
  %47 = load i64, ptr %46, align 8
  %48 = icmp eq i64 %47, 0
  br i1 %48, label %57, label %49

49:                                               ; preds = %44, %41
  %50 = load ptr, ptr @MemoryLeak3.localDAF, align 8
  %51 = getelementptr inbounds %struct.frameStruct_SQ, ptr %50, i32 0, i32 5
  %52 = load i64, ptr %51, align 8
  %53 = inttoptr i64 %52 to ptr
  %54 = getelementptr inbounds %struct.dafHdrStruct_SQ, ptr %53, i32 0, i32 2
  %55 = load i16, ptr %54, align 2
  %56 = sext i16 %55 to i32
  br label %58

57:                                               ; preds = %44, %34, %31, %27
  br label %58

58:                                               ; preds = %57, %49
  %59 = phi i32 [ %56, %49 ], [ 0, %57 ]
  %60 = trunc i32 %59 to i16
  %61 = call ptr @AddElement_SQ(ptr noundef %28, i16 noundef signext %60, ptr noundef null)
  br label %62

62:                                               ; preds = %58, %26
  %63 = phi ptr [ null, %26 ], [ %61, %58 ]
  store ptr %63, ptr @MemoryLeak3.localFrm, align 8
  %64 = load i64, ptr @totalBytes_SQ, align 8
  %65 = call i32 (ptr, ...) @printf(ptr noundef @.str.20, i64 noundef %64)
  store i32 1, ptr %1, align 4
  br label %66

66:                                               ; preds = %62, %19, %9
  %67 = load i32, ptr %1, align 4
  ret i32 %67
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @MemoryLeak4() #0 {
  %1 = alloca i32, align 4
  %2 = alloca ptr, align 8
  store ptr null, ptr %2, align 8
  %3 = load i64, ptr @totalBytes_SQ, align 8
  %4 = call i32 (ptr, ...) @printf(ptr noundef @.str.21, i64 noundef %3)
  %5 = load ptr, ptr %2, align 8
  %6 = icmp eq ptr %5, null
  br i1 %6, label %7, label %14

7:                                                ; preds = %0
  %8 = load ptr, ptr %2, align 8
  %9 = call ptr @CreateDAF_SQ(ptr noundef %8, i16 noundef signext 0)
  store ptr %9, ptr %2, align 8
  %10 = load ptr, ptr %2, align 8
  %11 = icmp eq ptr %10, null
  br i1 %11, label %12, label %13

12:                                               ; preds = %7
  store i32 0, ptr %1, align 4
  br label %19

13:                                               ; preds = %7
  br label %14

14:                                               ; preds = %13, %0
  %15 = load i64, ptr @.str.19, align 1
  %16 = load ptr, ptr %2, align 8
  store i64 %15, ptr %16, align 8
  %17 = load i64, ptr @totalBytes_SQ, align 8
  %18 = call i32 (ptr, ...) @printf(ptr noundef @.str.22, i64 noundef %17)
  store i32 1, ptr %1, align 4
  br label %19

19:                                               ; preds = %14, %12
  %20 = load i32, ptr %1, align 4
  ret i32 %20
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @NoMemoryLeak3() #0 {
  %1 = alloca i32, align 4
  %2 = load i64, ptr @totalBytes_SQ, align 8
  %3 = call i32 (ptr, ...) @printf(ptr noundef @.str.23, i64 noundef %2)
  %4 = load ptr, ptr @NoMemoryLeak3.localDAF, align 8
  %5 = icmp eq ptr %4, null
  br i1 %5, label %6, label %13

6:                                                ; preds = %0
  %7 = load ptr, ptr @NoMemoryLeak3.localDAF, align 8
  %8 = call ptr @CreateDAF_SQ(ptr noundef %7, i16 noundef signext 0)
  store ptr %8, ptr @NoMemoryLeak3.localDAF, align 8
  %9 = load ptr, ptr @NoMemoryLeak3.localDAF, align 8
  %10 = icmp eq ptr %9, null
  br i1 %10, label %11, label %12

11:                                               ; preds = %6
  store i32 0, ptr %1, align 4
  br label %18

12:                                               ; preds = %6
  br label %13

13:                                               ; preds = %12, %0
  %14 = load i64, ptr @.str.19, align 1
  %15 = load ptr, ptr @NoMemoryLeak3.localDAF, align 8
  store i64 %14, ptr %15, align 8
  %16 = load i64, ptr @totalBytes_SQ, align 8
  %17 = call i32 (ptr, ...) @printf(ptr noundef @.str.24, i64 noundef %16)
  store i32 1, ptr %1, align 4
  br label %18

18:                                               ; preds = %13, %11
  %19 = load i32, ptr %1, align 4
  ret i32 %19
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @NoMemoryLeak4() #0 {
  %1 = alloca i32, align 4
  %2 = alloca ptr, align 8
  store ptr null, ptr %2, align 8
  %3 = load i64, ptr @totalBytes_SQ, align 8
  %4 = call i32 (ptr, ...) @printf(ptr noundef @.str.25, i64 noundef %3)
  %5 = load ptr, ptr %2, align 8
  %6 = icmp eq ptr %5, null
  br i1 %6, label %7, label %14

7:                                                ; preds = %0
  %8 = load ptr, ptr %2, align 8
  %9 = call ptr @CreateDAF_SQ(ptr noundef %8, i16 noundef signext 0)
  store ptr %9, ptr %2, align 8
  %10 = load ptr, ptr %2, align 8
  %11 = icmp eq ptr %10, null
  br i1 %11, label %12, label %13

12:                                               ; preds = %7
  store i32 0, ptr %1, align 4
  br label %21

13:                                               ; preds = %7
  br label %14

14:                                               ; preds = %13, %0
  %15 = load i64, ptr @.str.19, align 1
  %16 = load ptr, ptr %2, align 8
  store i64 %15, ptr %16, align 8
  %17 = load ptr, ptr %2, align 8
  %18 = call ptr @DeleteFrame_SQ(ptr noundef %17)
  %19 = load i64, ptr @totalBytes_SQ, align 8
  %20 = call i32 (ptr, ...) @printf(ptr noundef @.str.26, i64 noundef %19)
  store i32 1, ptr %1, align 4
  br label %21

21:                                               ; preds = %14, %12
  %22 = load i32, ptr %1, align 4
  ret i32 %22
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local ptr @FunctionLevel3() #0 {
  %1 = call ptr @CreateFrame_SQ()
  ret ptr %1
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local ptr @FunctionLevel2() #0 {
  %1 = alloca ptr, align 8
  %2 = alloca ptr, align 8
  %3 = alloca i64, align 8
  store ptr null, ptr %2, align 8
  store i64 0, ptr %3, align 8
  %4 = call ptr @CreateFrame_SQ()
  store ptr %4, ptr %2, align 8
  %5 = load ptr, ptr %2, align 8
  %6 = icmp eq ptr %5, null
  br i1 %6, label %7, label %15

7:                                                ; preds = %0
  %8 = call ptr @FunctionLevel3()
  store ptr %8, ptr %2, align 8
  %9 = load ptr, ptr %2, align 8
  %10 = getelementptr inbounds %struct.frameStruct_SQ, ptr %9, i32 0, i32 5
  %11 = load i64, ptr %10, align 8
  store i64 %11, ptr %3, align 8
  %12 = load i64, ptr %3, align 8
  %13 = call i32 (ptr, ...) @printf(ptr noundef @.str.27, i64 noundef %12)
  %14 = load ptr, ptr %2, align 8
  store ptr %14, ptr %1, align 8
  br label %30

15:                                               ; preds = %0
  %16 = load i64, ptr @.str.28, align 1
  %17 = load ptr, ptr %2, align 8
  store i64 %16, ptr %17, align 8
  %18 = load ptr, ptr %2, align 8
  %19 = getelementptr inbounds %struct.frameStruct_SQ, ptr %18, i32 0, i32 1
  %20 = load i8, ptr %19, align 4
  %21 = zext i8 %20 to i32
  %22 = and i32 %21, -16
  %23 = or i32 %22, 0
  %24 = trunc i32 %23 to i8
  %25 = load ptr, ptr %2, align 8
  %26 = getelementptr inbounds %struct.frameStruct_SQ, ptr %25, i32 0, i32 1
  store i8 %24, ptr %26, align 4
  %27 = load ptr, ptr %2, align 8
  %28 = getelementptr inbounds %struct.frameStruct_SQ, ptr %27, i32 0, i32 5
  store i64 20, ptr %28, align 8
  %29 = load ptr, ptr %2, align 8
  store ptr %29, ptr %1, align 8
  br label %30

30:                                               ; preds = %15, %7
  %31 = load ptr, ptr %1, align 8
  ret ptr %31
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local ptr @FunctionLevel1() #0 {
  %1 = alloca ptr, align 8
  %2 = alloca i32, align 4
  %3 = alloca i64, align 8
  %4 = alloca ptr, align 8
  store i32 0, ptr %2, align 4
  store i64 0, ptr %3, align 8
  store ptr null, ptr %4, align 8
  %5 = call i32 @rand() #8
  store i32 %5, ptr %2, align 4
  %6 = load i32, ptr %2, align 4
  %7 = icmp sgt i32 %6, 250
  br i1 %7, label %8, label %10

8:                                                ; preds = %0
  %9 = call ptr @FunctionLevel2()
  store ptr %9, ptr %1, align 8
  br label %22

10:                                               ; preds = %0
  %11 = call ptr @FunctionLevel2()
  store ptr %11, ptr %4, align 8
  %12 = load ptr, ptr %4, align 8
  %13 = icmp ne ptr %12, null
  br i1 %13, label %14, label %21

14:                                               ; preds = %10
  %15 = load ptr, ptr %4, align 8
  %16 = getelementptr inbounds %struct.frameStruct_SQ, ptr %15, i32 0, i32 5
  %17 = load i64, ptr %16, align 8
  store i64 %17, ptr %3, align 8
  %18 = load i64, ptr %3, align 8
  %19 = call i32 (ptr, ...) @printf(ptr noundef @.str.27, i64 noundef %18)
  %20 = load ptr, ptr %4, align 8
  store ptr %20, ptr %1, align 8
  br label %22

21:                                               ; preds = %10
  store ptr null, ptr %1, align 8
  br label %22

22:                                               ; preds = %21, %14, %8
  %23 = load ptr, ptr %1, align 8
  ret ptr %23
}

; Function Attrs: nounwind
declare i32 @rand() #5

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @MemoryLeak5() #0 {
  %1 = alloca ptr, align 8
  store ptr null, ptr %1, align 8
  %2 = load i64, ptr @totalBytes_SQ, align 8
  %3 = call i32 (ptr, ...) @printf(ptr noundef @.str.29, i64 noundef %2)
  %4 = call ptr @FunctionLevel1()
  store ptr %4, ptr %1, align 8
  %5 = load i64, ptr @totalBytes_SQ, align 8
  %6 = call i32 (ptr, ...) @printf(ptr noundef @.str.30, i64 noundef %5)
  ret i32 1
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @MemoryLeak5_overflow() #0 {
  %1 = alloca ptr, align 8
  %2 = alloca [4 x i8], align 1
  store ptr null, ptr %1, align 8
  call void @llvm.memset.p0.i64(ptr align 1 %2, i8 0, i64 4, i1 false)
  %3 = load i64, ptr @totalBytes_SQ, align 8
  %4 = call i32 (ptr, ...) @printf(ptr noundef @.str.31, i64 noundef %3)
  %5 = call ptr @FunctionLevel1()
  store ptr %5, ptr %1, align 8
  %6 = load i64, ptr @totalBytes_SQ, align 8
  %7 = call i32 (ptr, ...) @printf(ptr noundef @.str.32, i64 noundef %6)
  %8 = getelementptr inbounds [4 x i8], ptr %2, i64 0, i64 0
  %9 = call ptr @strcpy(ptr noundef %8, ptr noundef @.str.9) #8
  ret i32 1
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @NoMemoryLeak5() #0 {
  %1 = alloca ptr, align 8
  store ptr null, ptr %1, align 8
  %2 = load i64, ptr @totalBytes_SQ, align 8
  %3 = call i32 (ptr, ...) @printf(ptr noundef @.str.33, i64 noundef %2)
  %4 = call ptr @FunctionLevel1()
  store ptr %4, ptr %1, align 8
  %5 = load ptr, ptr %1, align 8
  %6 = call ptr @DeleteFrame_SQ(ptr noundef %5)
  %7 = load i64, ptr @totalBytes_SQ, align 8
  %8 = call i32 (ptr, ...) @printf(ptr noundef @.str.34, i64 noundef %7)
  ret i32 1
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @MemoryLeak6() #0 {
  %1 = alloca ptr, align 8
  store ptr null, ptr %1, align 8
  %2 = load i64, ptr @totalBytes_SQ, align 8
  %3 = call i32 (ptr, ...) @printf(ptr noundef @.str.35, i64 noundef %2)
  %4 = call ptr @FunctionLevel1()
  store ptr %4, ptr %1, align 8
  %5 = call ptr @FunctionLevel3()
  store ptr %5, ptr %1, align 8
  %6 = load ptr, ptr %1, align 8
  %7 = call ptr @DeleteFrame_SQ(ptr noundef %6)
  %8 = load i64, ptr @totalBytes_SQ, align 8
  %9 = call i32 (ptr, ...) @printf(ptr noundef @.str.36, i64 noundef %8)
  ret i32 1
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @NoMemoryLeak6() #0 {
  %1 = load i64, ptr @totalBytes_SQ, align 8
  %2 = call i32 (ptr, ...) @printf(ptr noundef @.str.37, i64 noundef %1)
  %3 = load ptr, ptr @NoMemoryLeak6.localFrm, align 8
  %4 = icmp eq ptr %3, null
  br i1 %4, label %5, label %7

5:                                                ; preds = %0
  %6 = call ptr @FunctionLevel1()
  store ptr %6, ptr @NoMemoryLeak6.localFrm, align 8
  br label %7

7:                                                ; preds = %5, %0
  %8 = load ptr, ptr @NoMemoryLeak6.localFrm, align 8
  %9 = icmp eq ptr %8, null
  br i1 %9, label %10, label %12

10:                                               ; preds = %7
  %11 = call ptr @FunctionLevel3()
  store ptr %11, ptr @NoMemoryLeak6.localFrm, align 8
  br label %12

12:                                               ; preds = %10, %7
  %13 = load i64, ptr @totalBytes_SQ, align 8
  %14 = call i32 (ptr, ...) @printf(ptr noundef @.str.38, i64 noundef %13)
  ret i32 1
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @MemoryLeak7() #0 {
  %1 = load i64, ptr @totalBytes_SQ, align 8
  %2 = call i32 (ptr, ...) @printf(ptr noundef @.str.39, i64 noundef %1)
  %3 = call ptr @FunctionLevel1()
  store ptr %3, ptr @MemoryLeak7.localFrm, align 8
  %4 = load i64, ptr @totalBytes_SQ, align 8
  %5 = call i32 (ptr, ...) @printf(ptr noundef @.str.40, i64 noundef %4)
  ret i32 1
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @NoMemoryLeak7() #0 {
  %1 = load i64, ptr @totalBytes_SQ, align 8
  %2 = call i32 (ptr, ...) @printf(ptr noundef @.str.41, i64 noundef %1)
  %3 = load ptr, ptr @NoMemoryLeak7.localFrm, align 8
  %4 = icmp eq ptr %3, null
  br i1 %4, label %5, label %7

5:                                                ; preds = %0
  %6 = call ptr @FunctionLevel1()
  store ptr %6, ptr @NoMemoryLeak7.localFrm, align 8
  br label %7

7:                                                ; preds = %5, %0
  %8 = load i64, ptr @totalBytes_SQ, align 8
  %9 = call i32 (ptr, ...) @printf(ptr noundef @.str.42, i64 noundef %8)
  ret i32 1
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @NullCheck7() #0 {
  %1 = alloca ptr, align 8
  %2 = alloca i64, align 8
  store ptr null, ptr %1, align 8
  store i64 0, ptr %2, align 8
  %3 = call i32 (ptr, ...) @printf(ptr noundef @.str.43)
  %4 = call ptr @FunctionLevel1()
  store ptr %4, ptr %1, align 8
  %5 = load ptr, ptr %1, align 8
  %6 = getelementptr inbounds %struct.frameStruct_SQ, ptr %5, i32 0, i32 5
  %7 = load i64, ptr %6, align 8
  store i64 %7, ptr %2, align 8
  %8 = load i64, ptr %2, align 8
  %9 = call i32 (ptr, ...) @printf(ptr noundef @.str.44, i64 noundef %8)
  %10 = load ptr, ptr %1, align 8
  %11 = call ptr @DeleteFrame_SQ(ptr noundef %10)
  ret i32 1
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @NullCheck8() #0 {
  %1 = alloca ptr, align 8
  %2 = alloca i64, align 8
  store ptr null, ptr %1, align 8
  store i64 0, ptr %2, align 8
  %3 = call i32 (ptr, ...) @printf(ptr noundef @.str.45)
  %4 = call ptr @CreateFrame_SQ()
  store ptr %4, ptr %1, align 8
  %5 = load ptr, ptr %1, align 8
  %6 = getelementptr inbounds %struct.frameStruct_SQ, ptr %5, i32 0, i32 5
  %7 = load i64, ptr %6, align 8
  store i64 %7, ptr %2, align 8
  %8 = load i64, ptr %2, align 8
  %9 = call i32 (ptr, ...) @printf(ptr noundef @.str.46, i64 noundef %8)
  %10 = load ptr, ptr %1, align 8
  %11 = call ptr @DeleteFrame_SQ(ptr noundef %10)
  ret i32 1
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  store i32 0, ptr %1, align 4
  store i32 0, ptr %2, align 4
  br label %4

4:                                                ; preds = %72, %0
  %5 = call i32 (ptr, ...) @printf(ptr noundef @.str.47)
  %6 = call i32 (ptr, ...) @__isoc99_scanf(ptr noundef @.str.48, ptr noundef %2)
  %7 = load i32, ptr %2, align 4
  switch i32 %7, label %67 [
    i32 1, label %8
    i32 2, label %11
    i32 3, label %14
    i32 4, label %17
    i32 5, label %20
    i32 6, label %23
    i32 7, label %26
    i32 8, label %29
    i32 9, label %32
    i32 11, label %35
    i32 12, label %38
    i32 13, label %41
    i32 14, label %44
    i32 15, label %47
    i32 16, label %50
    i32 17, label %53
    i32 21, label %56
    i32 22, label %59
    i32 23, label %62
    i32 0, label %65
  ]

8:                                                ; preds = %4
  %9 = call i32 (ptr, ...) @printf(ptr noundef @.str.49)
  %10 = call i32 @MemoryLeak1()
  br label %69

11:                                               ; preds = %4
  %12 = call i32 (ptr, ...) @printf(ptr noundef @.str.50)
  %13 = call i32 @MemoryLeak2()
  br label %69

14:                                               ; preds = %4
  %15 = call i32 (ptr, ...) @printf(ptr noundef @.str.51)
  %16 = call i32 @MemoryLeak3()
  br label %69

17:                                               ; preds = %4
  %18 = call i32 (ptr, ...) @printf(ptr noundef @.str.52)
  %19 = call i32 @MemoryLeak4()
  br label %69

20:                                               ; preds = %4
  %21 = call i32 (ptr, ...) @printf(ptr noundef @.str.53)
  %22 = call i32 @MemoryLeak5()
  br label %69

23:                                               ; preds = %4
  %24 = call i32 (ptr, ...) @printf(ptr noundef @.str.54)
  %25 = call i32 @MemoryLeak6()
  br label %69

26:                                               ; preds = %4
  %27 = call i32 (ptr, ...) @printf(ptr noundef @.str.55)
  %28 = call i32 @NullCheck7()
  br label %69

29:                                               ; preds = %4
  %30 = call i32 (ptr, ...) @printf(ptr noundef @.str.56)
  %31 = call i32 @NullCheck7()
  br label %69

32:                                               ; preds = %4
  %33 = call i32 (ptr, ...) @printf(ptr noundef @.str.57)
  %34 = call i32 @NullCheck7()
  br label %69

35:                                               ; preds = %4
  %36 = call i32 (ptr, ...) @printf(ptr noundef @.str.58)
  %37 = call i32 @NoMemoryLeak1()
  br label %69

38:                                               ; preds = %4
  %39 = call i32 (ptr, ...) @printf(ptr noundef @.str.59)
  %40 = call i32 @NoMemoryLeak2()
  br label %69

41:                                               ; preds = %4
  %42 = call i32 (ptr, ...) @printf(ptr noundef @.str.60)
  %43 = call i32 @NoMemoryLeak3()
  br label %69

44:                                               ; preds = %4
  %45 = call i32 (ptr, ...) @printf(ptr noundef @.str.61)
  %46 = call i32 @NoMemoryLeak4()
  br label %69

47:                                               ; preds = %4
  %48 = call i32 (ptr, ...) @printf(ptr noundef @.str.62)
  %49 = call i32 @NoMemoryLeak5()
  br label %69

50:                                               ; preds = %4
  %51 = call i32 (ptr, ...) @printf(ptr noundef @.str.63)
  %52 = call i32 @NoMemoryLeak6()
  br label %69

53:                                               ; preds = %4
  %54 = call i32 (ptr, ...) @printf(ptr noundef @.str.64)
  %55 = call i32 @NoMemoryLeak6()
  br label %69

56:                                               ; preds = %4
  %57 = call i32 (ptr, ...) @printf(ptr noundef @.str.65)
  %58 = call i32 @NullCheck7()
  br label %69

59:                                               ; preds = %4
  %60 = call i32 (ptr, ...) @printf(ptr noundef @.str.66)
  %61 = call i32 @NullCheck7()
  br label %69

62:                                               ; preds = %4
  %63 = call i32 (ptr, ...) @printf(ptr noundef @.str.67)
  %64 = call i32 @NullCheck7()
  br label %69

65:                                               ; preds = %4
  %66 = call i32 (ptr, ...) @printf(ptr noundef @.str.68)
  store i32 1, ptr %1, align 4
  br label %76

67:                                               ; preds = %4
  %68 = call i32 (ptr, ...) @printf(ptr noundef @.str.68)
  br label %69

69:                                               ; preds = %67, %62, %59, %56, %53, %50, %47, %44, %41, %38, %35, %32, %29, %26, %23, %20, %17, %14, %11, %8
  %70 = call i32 (ptr, ...) @printf(ptr noundef @.str.69)
  %71 = call i32 (ptr, ...) @__isoc99_scanf(ptr noundef @.str.48, ptr noundef %3)
  br label %72

72:                                               ; preds = %69
  %73 = load i32, ptr %2, align 4
  %74 = icmp ne i32 %73, 0
  br i1 %74, label %4, label %75, !llvm.loop !8

75:                                               ; preds = %72
  store i32 1, ptr %1, align 4
  br label %76

76:                                               ; preds = %75, %65
  %77 = load i32, ptr %1, align 4
  ret i32 %77
}

declare i32 @__isoc99_scanf(ptr noundef, ...) #2

attributes #0 = { noinline nounwind optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nounwind allocsize(0) "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { nocallback nofree nounwind willreturn memory(argmem: write) }
attributes #4 = { nounwind willreturn memory(read) "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #5 = { nounwind "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #6 = { nocallback nofree nounwind willreturn memory(argmem: readwrite) }
attributes #7 = { nounwind allocsize(0) }
attributes #8 = { nounwind }
attributes #9 = { nounwind willreturn memory(read) }

!llvm.module.flags = !{!0, !1, !2, !3, !4}
!llvm.ident = !{!5}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"PIE Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 2}
!4 = !{i32 7, !"frame-pointer", i32 2}
!5 = !{!"Debian clang version 16.0.6 (19)"}
!6 = distinct !{!6, !7}
!7 = !{!"llvm.loop.mustprogress"}
!8 = distinct !{!8, !7}
