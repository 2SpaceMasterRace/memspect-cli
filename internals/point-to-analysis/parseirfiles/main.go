///home/bala/memoryleakproject/parser/

package main
import (
	"bufio"
	"fmt"
	"log"
	"os"
	"strings"
    "encoding/json"
)
var pointstoset = make(map[string]map[string][]string)


func workingwithfunction(lines [][]string){
	name:=string(lines[0][3])
	index:=strings.Index(name,"(")
	functionname:= name[:index]
	pointstoset[functionname] = make(map[string][]string)
	callingfunction:=""
	for _,line := range lines {
		variables := []string{}
		var todo string
		for _,x := range line{
			if strings.HasPrefix(x,"%"){
				index=strings.Index(x,")")
				if(index!=-1){
					x=x[:index]
				}
				variables=append(variables, x)
			}else if x=="alloca"{
				todo="alloca"
			}else if x=="store"{
				todo="store"
			}else if x=="load"{
				todo="load"
			}else if x=="call"{
				todo="call"
			}else if strings.HasPrefix(x,"@"){
				index=strings.Index(x,"(")
				if index!=-1{
					callingfunction=x[:index]
				}
			}else if (x=="fadd" || x=="fsub" || x=="fmul" || x=="fdiv"){
				todo="arithmeticoperations"
				callingfunction=x
			}else if x=="ret"{
				todo="ret"
			}
		}
		if todo=="alloca"{
			allocaoperation(variables,functionname)
		}else if todo=="store"{
			storeoperation(variables,functionname)
		}else if todo=="load"{
			loadoperation(variables,functionname)
		}else if todo=="call"{
			calloperation(variables,functionname,callingfunction)
		}else if todo=="arithmeticoperations"{
			arithmeticoperations(variables,functionname,callingfunction)
		}else if todo=="ret"{
			returnoperation(variables,functionname)
		}
	}
}

func returnoperation(variables []string,functionname string){
	if(len(variables)==0){
		return 
	}
	pointtoset:=pointstoset[functionname]
	pointtoset["return"]=[]string{}
	retrievearray:=pointtoset["return"]
	retrievearray=append(retrievearray, variables...)
	pointtoset["return"]=retrievearray


}

func arithmeticoperations(variables []string,functionname string,callingfunction string){
	pointtoset:=pointstoset[functionname]
	pointtoset[variables[0]]=[]string{}
	retrievearray:=pointtoset[variables[0]]
	retrievearray=append(retrievearray, callingfunction)
	variable:=variables[0]
	variables=variables[1:]
	retrievearray=append(retrievearray, variables...)
	pointtoset[variable]=retrievearray
}


func calloperation (variables []string,functionname string,callingfunction string){
	pointtoset:=pointstoset[functionname]
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
		retrivearray=append(retrivearray,variables...)
		pointtoset[variable]=retrivearray

	}

}

func allocaoperation(variables []string, functionname string){
	pointtoset:=pointstoset[functionname]
	pointtoset[variables[0]]= []string{}
	pointstoset[functionname]=pointtoset
}
func loadoperation(variables []string,functionname string){
	pointtoset:=pointstoset[functionname]
	variable1:=variables[0]
	pointtoset[variable1]=[]string{}
	retrievearray1:=pointtoset[variable1]
	variable2:=variables[1][:len(variables[1])-1]
	retrievearray1=append(retrievearray1,variable2)
	pointtoset[variable1]=retrievearray1
	pointstoset[functionname]=pointtoset
}
func storeoperation (variables[]string,functionname string){
	//first we are retriving the variable from the dictionary
	//now we are going to check the sizee of the array it is 2 then a temporary variable is being used
	//the length of the array is 1
	pointtoset:=pointstoset[functionname]
	if(len(variables)==1){
		variable:=variables[0][:len(variables[0])-1]
		retrievearray:=pointtoset[variable]
		retrievearray=append(retrievearray, "num")
		pointtoset[variable]=retrievearray
	}else{
		variable1:=variables[0][:len(variables[0])-1]
		retrievearray1:=pointtoset[variable1]
		variable2:=variables[1][:len(variables[1])-1]
		retrievearray2:=pointtoset[variable2]
		retrievearray2=append(retrievearray2,retrievearray1...)
		pointtoset[variable2]=retrievearray2
		delete(pointtoset,variable1)
	}
	pointstoset[functionname]=pointtoset
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
	_,err:=fmt.Scan(&filepath)
	if err != nil{
		log.Fatal(err)
	}
	irfiles=readingirfiles(filepath)
	fmt.Println("Availalbe IR files:")
	for _,files := range(irfiles){
		fmt.Println(files)
		parseirfiles(filepath,files)
	}
}