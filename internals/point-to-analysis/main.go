///home/bala/memoryleakproject/parser/

package main

import (
	"bufio"
	"encoding/json"
	"fmt"
	"log"
	"os"
	"strings"
)
var pointstoset = make(map[string]map[string][]string)
var breakname string
var breakflag int
var hasvariable int
func workingwithfunction(lines [][]string){
	breakflag=0
	name:=string(lines[0][3])
	functiontype:=string(lines[0][2])
	if(functiontype=="ptr"){
		functiontype="ptr"
	}else if(functiontype=="void"){
		functiontype="void"
	}
	index:=strings.Index(name,"(")
	functionname:= name[:index]
	functionname=functiontype+"("+functionname+")"
	pointstoset[functionname] = make(map[string][]string)
	pointtoset:=pointstoset[functionname]
	callingfunction:=""
	fmt.Println(lines)
	for _,line := range lines {
		hasvariable=0
		fmt.Println(len(line))
		variables := []string{}
		var todo string
		for _,x := range line{
			if strings.HasPrefix(x,"%"){
				index=strings.Index(x,")")
				if(index!=-1){
					x=x[:index]
				}
				variables=append(variables, x)
				hasvariable=1
			}else if x=="alloca"{
				todo="alloca"
				hasvariable=1
			}else if x=="store"{
				todo="store"
				hasvariable=1

			}else if x=="load"{
				todo="load"
				hasvariable=1

			}else if x=="call"{
				todo="call"
				hasvariable=1

			}else if strings.HasPrefix(x,"@"){
				index=strings.Index(x,"(")
				if index!=-1{
					callingfunction=x[:index]
				}
				hasvariable=1

			}else if (x=="fadd" || x=="fsub" || x=="fmul" || x=="fdiv" || x=="mul" || x=="add"){
				todo="arithmeticoperations"
				callingfunction=x
			}else if x=="ret"{
				todo="ret"
				hasvariable=1
			}else if x=="define"{
				fmt.Println("I am coming here")
				todo="functionvariables"
				hasvariable=1
			}else if x=="icmp"{
				todo="icmp"
				total:=len(line)
				variable1:= line[total-2]
				variable1=variable1[0:len(variable1)-1]
				variable2:= line[total-1]				
				variables=append(variables, variable1)
				variables=append(variables, variable2)
				callingfunction=x
				hasvariable=1
				break
			}else if x=="br"{
				todo="br"
				hasvariable=1
			}else if strings.HasSuffix(x,":"){
				hasvariable=1
				x=x[:len(x)-1]
				fmt.Println(x)
				breakflag=1
				breakname=x
				pointtoset[x]=[]string{}
				retrievearray:=pointtoset[x]
				fmt.Println(breakname)
				startflag:=0
				for _,y:=range line{
					if y==";"{
						startflag=1
						retrievearray=append(retrievearray, "(")
					}
					if startflag==1{
						retrievearray=append(retrievearray,y)
					}
				}
				retrievearray=append(retrievearray, ")")
				pointtoset[x]=retrievearray
			}else if x=="zext"{
				todo="cutoperation"
				callingfunction="zext"
			}else if x=="trunc"{
				todo="cutoperation"
				callingfunction="trunc"
			}else if x=="getelementptr"{
				todo="getelementptr"
				break
			}
			}
			
		if(hasvariable==0 && breakflag==1){
			breakflag=0
		}
		variables=removeextracomma(variables)
		if todo=="alloca"{
			if breakflag==1{
				retrievearray:=pointtoset[breakname]
				retrievearray=append(retrievearray, variables[0])
				pointtoset[breakname]=retrievearray
			}
			allocaoperation(variables,pointstoset[functionname])
		}else if todo=="store"{
			storeoperation(line,pointstoset[functionname])

		}else if todo=="load"{
			if breakflag==1{
				retrievearray:=pointtoset[breakname]
				retrievearray=append(retrievearray, variables[0])
				pointtoset[breakname]=retrievearray
			}
			loadoperation(line,pointstoset[functionname])
		}else if todo=="call"{
			if breakflag==1{
				retrievearray:=pointtoset[breakname]
				retrievearray=append(retrievearray, variables[0])
				pointtoset[breakname]=retrievearray
			}
			calloperation(variables,pointstoset[functionname],callingfunction)
		}else if todo=="arithmeticoperations"{
			if breakflag==1{
				retrievearray:=pointtoset[breakname]
				retrievearray=append(retrievearray, variables[0])
				pointtoset[breakname]=retrievearray
			}
			arithmeticoperations(variables,pointstoset[functionname],callingfunction)
		}else if todo=="ret"{
			if breakflag==1{
				retrievearray:=pointtoset[breakname]
				variable:="return"+variables[0]
				retrievearray=append(retrievearray, variable)
				pointtoset[breakname]=retrievearray
			}
			returnoperation(variables,pointstoset[functionname])
		}else if todo=="functionvariables"{
			if breakflag==1{
				retrievearray:=pointtoset[breakname]
				retrievearray=append(retrievearray, variables[0])
				pointtoset[breakname]=retrievearray
			}
			fmt.Println("Is there is any ",variables)
			allocaoperation(variables,pointstoset[functionname])
		}else if todo=="icmp"{
			fmt.Println(breakflag,"hello",breakname)
			if breakflag==1{
				retrievearray:=pointtoset[breakname]
				retrievearray=append(retrievearray, variables[0])
				pointtoset[breakname]=retrievearray
			}
			arithmeticoperations(variables,pointstoset[functionname],callingfunction)
		}else if todo=="br"{
			if breakflag==1{
				retrievearray:=pointtoset[breakname]
				retrievearray=append(retrievearray, variables[0])
				pointtoset[breakname]=retrievearray
			}
			breakoperations(variables,pointstoset[functionname])
		}else if todo=="cutoperation"{
			if breakflag==1{
				retrievearray:=pointtoset[breakname]
				retrievearray=append(retrievearray, variables[0])
				pointtoset[breakname]=retrievearray
			}
			cutoperation(variables,pointstoset[functionname],callingfunction)			
		}else if todo=="getelementptr"{
			if breakflag==1{
				retrievearray:=pointtoset[breakname]
				retrievearray=append(retrievearray, variables[0])
				pointtoset[breakname]=retrievearray
			}
			getelementptr(line,pointtoset)
		}
	}
}

func getelementptr(line []string, pointtoset map[string][]string){
	//Variable1 @2
	//Structure @6
	//Next variable @8
	//Values a@ 10,12
	total:=len(line)
	pointtoset[line[2]]=[]string{}
	retrievearray:=pointtoset[line[2]]
	retrievearray=append(retrievearray, line[6],line[8],"(")
	for i:=10;i<total;i+=2{
		retrievearray=append(retrievearray, line[i])
	}
	retrievearray=append(retrievearray, ")")
	retrievearray=removeextracomma(retrievearray)
	pointtoset[line[2]]=retrievearray
}

func cutoperation(variables []string,pointtoset map[string][]string,callingfunction string){
	pointtoset[variables[0]]=[]string{}
	retrivearray:=pointtoset[variables[0]]
	variable:=variables[1]
	variable=callingfunction+"("+variable+")"
	retrivearray=append(retrivearray, variable)
	pointtoset[variables[0]]=retrivearray
}



func removeextracomma(variables []string) []string{
	total:=len(variables)
	for i:=0;i<total;i++{
		if strings.HasSuffix(variables[i],","){
			variable:=variables[i]
			variable=variable[:len(variable)-1]
			variables[i]=variable
		}

	}
	return variables
}

func removepercentagesymbol(variables []string) []string{
	total:=len(variables)
	for i:=0;i<total;i++{
		if strings.HasPrefix(variables[i],"%"){
			variable:=variables[i]
			variable=variable[1:]
			variables[i]=variable
		}

	}
	return variables
}





func breakoperations(variables []string,pointtoset map[string][]string){
	variables=removeextracomma(variables)
	variables=removepercentagesymbol(variables)
	pointtoset["br"+variables[0]]=[]string{}
	retrievearray:=pointtoset["br"+variables[0]]
	variable:="br"+variables[0]
	variables=variables[1:]
	retrievearray=append(retrievearray, variables...)
	pointtoset[variable]=retrievearray

}



func returnoperation(variables []string,pointtoset map[string][]string){
	if(len(variables)==0){
		return 
	}
	pointtoset["return"]=[]string{}
	retrievearray:=pointtoset["return"]
	retrievearray=append(retrievearray, variables...)
	pointtoset["return"]=retrievearray


}

func arithmeticoperations(variables []string,pointtoset map[string][]string,callingfunction string){
	pointtoset[variables[0]]=[]string{}
	retrievearray:=pointtoset[variables[0]]
	retrievearray=append(retrievearray, callingfunction)
	variable:=variables[0]
	variables=variables[1:]
	retrievearray=append(retrievearray, "(")
	retrievearray=append(retrievearray, variables...)
	retrievearray=append(retrievearray, ")")
	pointtoset[variable]=retrievearray
}


func calloperation (variables []string,pointtoset map[string][]string,callingfunction string){
	if(callingfunction=="@__isoc99_scanf"){
		pointtoset[variables[0]]=[]string{}
		retrivearray:=pointtoset[variables[0]]
		retrivearray=append(retrivearray, "scanf")
		variable:=variables[0]
		variables=variables[1:]
		retrivearray=append(retrivearray,variables...)
		pointtoset[variable]=retrivearray
	}else{
		pointtoset[variables[0]]=[]string{}
		retrivearray:=pointtoset[variables[0]]
		retrivearray=append(retrivearray, callingfunction)
		variable:=variables[0]
		variables=variables[1:]
		retrivearray=append(retrivearray,"(")
		retrivearray=append(retrivearray,variables...)
		retrivearray=append(retrivearray,")")
		pointtoset[variable]=retrivearray

	}

}

func allocaoperation(variables []string, pointtoset map[string][]string){
	for _,x := range variables{
		fmt.Println("Variables are here:",x)
		pointtoset[x]= []string{}
	}

}
func loadoperation(line []string,pointtoset map[string][]string){
	// variable1:=variables[0]
	// pointtoset[variable1]=[]string{}
	// retrievearray1:=pointtoset[variable1]
	// variable2:=variables[1][:len(variables[1])-1]
	// retrievearray1=append(retrievearray1,variable2)
	// pointtoset[variable1]=retrievearray1
	//Variable1@ 2
	//Variable1 type @ 5
	//Variable2@ 7
	variable1:=line[2]
	variable2:=line[7]
	variable2=variable2[:len(variable2)-1]
	type1:=line[5]
	if(type1=="ptr,"){
		variable2="loadaddr("+variable2+")"
	}else{
		variable2="load("+variable2+")"
	}
	pointtoset[variable1]=[]string{}
	retrivearray:=pointtoset[variable1]
	retrivearray=append(retrivearray, variable2)
	pointtoset[variable1]=retrivearray
}
func storeoperation (line[]string,pointtoset map[string][]string){
	//first we are retriving the variable from the dictionary
	//now we are going to check the sizee of the array it is 2 then a temporary variable is being used
	//the length of the array is 1
	// if(len(variables)==1){
	// 	variable:=variables[0][:len(variables[0])-1]
	// 	retrievearray:=pointtoset[variable]
	// 	retrievearray=append(retrievearray, "num")
	// 	pointtoset[variable]=retrievearray
	// }else{
	// 	variable1:=variables[0][:len(variables[0])-1]
	// 	retrievearray1:=pointtoset[variable1]
	// 	variable2:=variables[1][:len(variables[1])-1]
	// 	retrievearray2:=pointtoset[variable2]
	// 	retrievearray2=append(retrievearray2,retrievearray1...)
	// 	pointtoset[variable2]=retrievearray2
	// }
	//Type1 @3
	//Variable 1 @4
	//Type2 @5
	//Variable 2 @6
	variable1:=line[4]
	variable1=variable1[:len(variable1)-1]
	type1:=line[3]
	variable2:=line[6]
	variable2=variable2[:len(variable2)-1]
	if type1=="ptr"{
		
		retrievearray:=pointtoset[variable2]
		variable1="addr("+variable1+")"
		retrievearray=append(retrievearray, variable1)
		pointtoset[variable2]=retrievearray
	}else{
		retrievearray:=pointtoset[variable2]
		retrievearray=append(retrievearray, variable1)
		pointtoset[variable2]=retrievearray
	}
}
func parseirfiles(filepath string, irfilename string){
	filepath=fmt.Sprintf("%s/%s",filepath,irfilename)
	file,err:=os.Open(filepath)
	if err!=nil{
		fmt.Println("Error opening the fiie:",err)
	}
	defer file.Close()

	scanner:=bufio.NewScanner(file)
	lines:=[][]string{}
	var flag int
	flag=0
	for scanner.Scan(){
		words :=scanner.Text()
		line := strings.Split(words," ")
		if(line[0]=="define"){
			lines=append(lines,line)
			flag=1
		}else if(line[0]=="}"){
			if(flag==1){
				workingwithfunction(lines)
			}
			emptyarr:=[][]string{}
			lines=emptyarr
			flag=0
		}else if(flag==1){
			lines= append(lines,line )
		}
	}
	if err:=scanner.Err(); err!=nil{
		fmt.Println("Error scanning file:",err)
		return
	}

	jsonfile,err := os.Create("results.json")
	if err != nil{
        fmt.Println("Error creating file:", err)
        return
	}

	defer jsonfile.Close()

    // Marshal the map into JSON format
    jsonData, err := json.MarshalIndent(pointstoset, "", "    ")
    if err != nil {
        fmt.Println("Error marshalling to JSON:", err)
        return
    }

    // Write the JSON data to the file
    _, err = jsonfile.Write(jsonData)
    if err != nil {
        fmt.Println("Error writing JSON to file:", err)
        return
    }

    fmt.Println("JSON data written to file successfully")
	fmt.Println(pointstoset)
}

//This function will look for all the available ir files in the specified directory
func readingirfiles(filepath string)[]string{
	dir,err:=os.Open(filepath)
	var irfiles []string
	if err!=nil{
		log.Fatal(err)

	}
	defer dir.Close()
	files,err:=dir.Readdir(-1)
	if err!=nil{
		log.Fatal(err)
	}
	fmt.Println("Available IR files in ",filepath)

	for _,file :=range files{
		if strings.Contains(file.Name(),".ll") && !strings.Contains(file.Name(),".swp"){
			irfiles = append(irfiles,file.Name())
		}
	}
	return irfiles
}
// Here we are receiving the filepath from the user
func main(){

	//Variable Declarations
	var irfiles []string
	var filepath string

	fmt.Print("Enter the file path:")
	// _,err:=fmt.Scan(&filepath)
	// if err != nil{
	// 	log.Fatal(err)
	// }
	filepath="/home/bala/memoryleakproject/parser/parserirfiles"
	irfiles=readingirfiles(filepath)
	fmt.Println("Availalbe IR files:")
	for _,files := range(irfiles){
		fmt.Println(files)
		parseirfiles(filepath,files)
	}
}


/*11:                                               ; preds = %2
  store ptr null, ptr %3, align 8
  br label %57

12:                                               ; preds = %2
  %13 = load i32, ptr %4, align 4
  %14 = load i32, ptr %5, align 4
  %15 = mul i32 %13, %14
  %16 = zext i32 %15 to i64
  %17 = add i64 %16, 4
  %18 = call noalias ptr @malloc(i64 noundef %17) #5
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
  %51 = add i64 %50, 8
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
}*/