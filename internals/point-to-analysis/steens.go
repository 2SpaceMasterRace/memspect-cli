package main

import (
	"bufio"
	"encoding/json"
	"fmt"
	"os"
	"strconv"
	"strings"
	"github.com/dominikbraun/graph"
    "github.com/dominikbraun/graph/draw"

)
var pointstoset=make(map[string]map[string][]string)
var goingtoload=0

func buildstensgaard(pointset map[string][]string){
	for i:=0;i<7;i++{
		newarray:=[]string {}
		variable:="%"+strconv.Itoa(i)
		// fmt.Println("Variable:",variable,"Value:",functionname[variable])
		if _, ok := pointset[variable]; ok {
			retrievearray:=pointset[variable]
			for _,i:=range retrievearray{
				if(strings.HasPrefix(i,"addr")){
					variable2:=i[5:len(i)-1]
					retrievearray2:=pointset[variable2]
					for _,j:=range retrievearray2{
						if(strings.HasPrefix(j,"addr")){
							newarray=append(newarray, retrievearray2...)
							break
						}
					}
				}
			}
			if(len(newarray)!=0){
				for _,i:=range retrievearray{
					if(strings.HasPrefix(i,"addr")){
						variable:=i[5:len(i)-1]
						pointset[variable]=newarray
					}
				}
			}

			
		} 
	}
}
func solveconstraint(variable string, function map[string][]string){
	retrivearray:=function[variable]
	newarray:=[]string {}
	for i:=0;i<len(retrivearray);i++{
		value:=retrivearray[i]
		if(strings.HasPrefix(value,"%")){
			retrivearray2:=function[value]
			function[variable]=retrivearray2
			return
		}else if (value=="mul" || value=="zext" || value=="trunc" || value=="icmp" || value=="add" || value=="@printf"){
			return
		}else if (value=="addr(null)"){
			newarray=append(newarray,"null")
		}else if(strings.HasPrefix(value,"addr(")){
			variable2:=value[5:len(value)-1]
			solveconstraint(variable2,function)
			if(goingtoload==1){
				retrivearray2:=function[variable2]
				newarray=append(newarray, retrivearray2...)
				goingtoload=0
			}else{
				return
			}
		}else if strings.HasPrefix(value,"loada"){
			goingtoload=1
			variable3:=value[9:len(value)-1]
			retrivearray:=function[variable3]
			value4:=retrivearray[0]
			if(strings.HasPrefix(value4,"loada")){
				variable4:=value4[9:len(value4)-1]
				retrivearray2:=function[variable4]
				updatearray:=[]string{}
				for _,values:=range retrivearray2{
					variable5:=values[5:len(values)-1]
					retrivearray3:=function[variable5]
					updatearray=append(updatearray, retrivearray3...)
				}
				function[variable]=updatearray
				return
			}
			function[variable]=retrivearray
			return
		}else if strings.HasPrefix(value,"load"){
			variable2:=value[5:len(value)-1]
			retrivearray2:=function[variable2]
			function[variable]=retrivearray2
			return
		}else{
			return
		}
	}
	function[variable]=newarray
}

func receiveset(function string, functionname map[string][]string){
	g := graph.New(graph.StringHash, graph.Directed())
	for key:=range functionname{
		key=key[1:]
		_ = g.AddVertex(key)
	}
	for i:=0;i<100;i++{
		variable:="%"+strconv.Itoa(i)
		// fmt.Println("Variable:",variable,"Value:",functionname[variable])
		if _, ok := functionname[variable]; ok {
		// fmt.Println("Variable:",variable,"Value:",functionname[variable])
		solveconstraint(variable,functionname)
		fmt.Println("The varialble", variable,"points to",functionname[variable])
		retrievearray:=functionname[variable]
		variable=variable[1:]
		for _,i:= range retrievearray{
			if strings.HasPrefix(i,"addr("){
				variable2:=i[6:len(i)-1]
				_ = g.AddEdge(variable,variable2)
			}else{
				i="const("+i+")"
				_ = g.AddVertex(i)
				_ = g.AddEdge(variable,i)

			}
		}
		} 
	}
	anderfunction:=function[5:len(function)-1]
	anderfunction=anderfunction+"andersen"+".gv"
	anderfile, _ := os.Create(anderfunction)
	_ = draw.DOT(g, anderfile)
	fmt.Println("After the andersen we are going to stensgaard")
	for i:=0;i<100;i++{
		variable:="%"+strconv.Itoa(i)
		// fmt.Println("Variable:",variable,"Value:",functionname[variable])
		if _, ok := functionname[variable]; ok {
		fmt.Println("Variable:",variable,"Value:",functionname[variable])
		// solveconstraint(variable,functionname)
		// fmt.Println("The varialble", variable,"points to",functionname[variable])
		} 
	}
	buildstensgaard(functionname)
	steensgaard := graph.New(graph.StringHash, graph.Directed())
	for key:=range functionname{
		key=key[1:]
		_ = steensgaard.AddVertex(key)
	}
	fmt.Println("The steensgaard value is")
	for i:=0;i<100;i++{
		variable:="%"+strconv.Itoa(i)
		// fmt.Println("Variable:",variable,"Value:",functionname[variable])
		if _, ok := functionname[variable]; ok {
		// fmt.Println("Variable:",variable,"Value:",functionname[variable])
		// solveconstraint(variable,functionname)
		// retrievearray:=functionname[variable]
		// variable=variable[1:]
		// for _,i:= range retrievearray{
		// 	if strings.HasPrefix(i,"addr("){
		// 		// variable2:=i[6:len(i)-1]
		// 		// _ = steensgaard.AddEdge(variable,variable2)
		// 	}else{
		// 		i="const("+i+")"
		// 		// _ = steensgaard.AddVertex(i)
		// 		// _ = steensgaard.AddEdge(variable,i)

		// 	}
		// }
		fmt.Println("The varialble", variable,"points to",functionname[variable])
		variable=variable[1:]
		retrievearray:=functionname[variable]
		for _,i:= range retrievearray{
			if strings.HasPrefix(i,"addr("){
				variable2:=i[6:len(i)-1]
				_ = steensgaard.AddEdge(variable,variable2)
			}else{
				i="const("+i+")"
				_ = steensgaard.AddVertex(i)
				_ = steensgaard.AddEdge(variable,i)

			}
		}		
		
		} 

	}

	steensfunction:=function[5:len(function)-1]
	steensfunction=steensfunction+"steensgaard"+".gv"
	steensfiles, _ := os.Create(steensfunction)
	_ = draw.DOT(steensgaard, steensfiles)
	// solveconstraint("%6",functionname)
	// fmt.Println("The varialble %3 points to",functionname["%6"])
}





func main(){
	fmt.Println("Hello World")
	filepath:="/home/bala/memoryleakproject/stensgaard/results.json"
	file,err:=os.Open(filepath)
	if err!=nil{
		fmt.Println("There is a error while opening the JSON file")
		return 
	}
	defer file.Close()
	scanner := bufio.NewScanner(file)
	var lines []string
	for scanner.Scan() {
		lines = append(lines, scanner.Text())
	}

	// Concatenate lines into a single string
	jsonStr := ""
	for _, line := range lines {
		jsonStr += line
	}

	// Parse JSON into map
	err = json.Unmarshal([]byte(jsonStr), &pointstoset)
	if err != nil {
		fmt.Println("Error parsing JSON:", err)
		return
	}

	// Print the dictionary
	for key, value := range pointstoset {
		fmt.Println("Function Name:",key)
		receiveset(key,value)
	}

}