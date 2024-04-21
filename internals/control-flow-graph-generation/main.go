package main

import (
	"bufio"
	"fmt"

	// "bufio"
	// "encoding/json"
	// "fmt"
	"log"
	"os"
	"strings"
	"github.com/dominikbraun/graph"
	"github.com/dominikbraun/graph/draw"

)

var functions=make(map[string][][]string)
var g=graph.New(graph.StringHash,graph.Directed())


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

func connect(from string,to string){
	_=g.AddEdge(from,to)
}

func addvertex(value string){
	_=g.AddVertex(value)
}
func resolvebreak(breakstatements map[string][]string,breakvalue map[string][]string){
	for key,value:= range breakstatements{
		too:=breakvalue[key]
		if(len(too)==0){
			continue
		}
		to:=too[0]
		for _,i :=range(value){
			from:=i
			connect(from,to)
		}
	}
}



func nextfunction(end string,functionname string) string{
	mainarray:=functions[functionname]
	fmt.Println(mainarray)
	firstline:=mainarray[0]
	from:=""
	flag:=0
	for _,i:=range(firstline){
		if(strings.HasPrefix(i,"@")){
			from=from+string(i)+" "
			flag=1
		}else if(flag==1){
			from=from+string(i)+" "

		}else if (strings.HasPrefix(i,"}")){
			from=from+string(i)
			break
		}
	}
	mainarray=mainarray[1:]
	functionname="func{"+functionname+"}"
	from=from[:len(from)-5]
	addvertex(from)
	connect(end,from)
	to:=""
	breakstatements:=map[string][]string{}
	breakvalues:=map[string][]string{}
	for _,lines:= range(mainarray){
		if(len(lines)==1){
			continue
		}else if(string(lines[2])=="br"){
			if(strings.HasSuffix(from," @")){
				from=from[:len(from)-2]
				retrievearray:=breakstatements[lines[4][1:]]
				if(len(retrievearray)==0){
					breakstatements[lines[4][1:]]=[]string{}
					retrievearray2:=breakstatements[from]
					retrievearray=breakstatements[lines[4][1:]]
					retrievearray=append(retrievearray, retrievearray2...)
					breakstatements[lines[4][1:]]=retrievearray
					continue
				}
				retrievearray2:=breakstatements[from]
				retrievearray=append(retrievearray, retrievearray2...)
				breakstatements[lines[4][1:]]=retrievearray		
				continue		
			}

			if(len(lines)==5 || len(lines)==7){
				v:=string(lines[4][1:])
				if(strings.HasSuffix(v,",")){
					v=v[:len(v)-1]
				}
				retrievearray:=breakstatements[v]
				if(len(retrievearray)==0){
					breakstatements[lines[4][1:]]=[]string{}
					retrievearray:=breakstatements[v]
					retrievearray=append(retrievearray, from)
					breakstatements[v]=retrievearray					
				}else{
					retrievearray=append(retrievearray, from)
					breakstatements[v]=retrievearray
				}
			}else{
				v1:=string(lines[6][1:len(lines[6])-1])
				retrievearray:=breakstatements[v1]
				if(len(retrievearray)==0){
					breakstatements[v1]=[]string{}
					retrievearray=append(retrievearray, from)
					breakstatements[v1]=retrievearray
				}else{
					retrievearray=append(retrievearray, from)
					breakstatements[v1]=retrievearray
				}
				v2:=lines[8][1:]
				retrievearray1:=breakstatements[v2]
				if(len(retrievearray1)==0){
					breakstatements[v2]=retrievearray1
					retrievearray1=append(retrievearray1, from)
					breakstatements[v2]=retrievearray1					

				}else{
					retrievearray1=append(retrievearray1, from)
					breakstatements[v2]=retrievearray1
				}
			}
			continue
		}else if(strings.HasSuffix(lines[0],":")){
			value:=string(lines[0])
			from=value[:len(value)-1]
			from=from+" @"
			continue
		}else if(strings.HasSuffix(from," @")){
			from=from[:len(from)-2]
			if(string(lines[2])=="br"){
				from=from[:len(from)-2]
				retrievearray:=breakstatements[lines[4][1:]]
				if(len(retrievearray)==0){
					breakstatements[lines[4][1:]]=[]string{}
					retrievearray2:=breakstatements[from]
					retrievearray=breakstatements[lines[4][1:]]
					retrievearray=append(retrievearray, retrievearray2...)
					breakstatements[lines[4][1:]]=retrievearray
					continue
				}
				retrievearray2:=breakstatements[from]
				retrievearray=append(retrievearray, retrievearray2...)
				breakstatements[lines[4][1:]]=retrievearray		
				continue		
			}
			retrievearray:=breakvalues[from]
			if(len(retrievearray)==0){
				breakvalues[from]=[]string{}
				retrievearray=breakvalues[from]
			}
			to=strings.Join(lines," ")
			to=functionname+to
			retrievearray=append(retrievearray, to)
			breakvalues[from]=retrievearray
			addvertex(to)
			from=to
			to=""
			continue
		}else if(string(lines[4])=="call"){
			function:=lines[6]
			to=strings.Join(lines," ")
			to=functionname+to
			addvertex(to)
			connect(from,to)
			from=to
			index:=strings.Index(function,"(")
			function=function[0:index]
			retrievearray:=functions[function]
			if(len(retrievearray)!=0){
				nextfunction(from,function)
				continue
			}else{
				continue
			}
		}
		to=strings.Join(lines," ")
		to=functionname+to
		addvertex(to)
		connect(from,to)
		from=to
		to=""
	}
	fmt.Println(breakstatements)
	fmt.Println(breakvalues)
	resolvebreak(breakstatements,breakvalues)
	return from
}




func generategraph(){
	mainarray:=functions["@main"]
	mainarray=mainarray[1:]
	addvertex("entry")
	addvertex("@main()")
	connect("entry","@main()")
	from:="@main()"
	to:=""
	functionname:="func{main}"
	breakstatements:=map[string][]string{}
	breakvalues:=map[string][]string{}
	for _,lines:= range(mainarray){
		if(len(lines)==1){
			continue
		}else if(string(lines[2])=="br"){
			if(strings.HasSuffix(from," @")){
				from=from[:len(from)-2]
				retrievearray:=breakstatements[lines[4][1:]]
				if(len(retrievearray)==0){
					breakstatements[lines[4][1:]]=[]string{}
					retrievearray2:=breakstatements[from]
					retrievearray=breakstatements[lines[4][1:]]
					retrievearray=append(retrievearray, retrievearray2...)
					breakstatements[lines[4][1:]]=retrievearray
					continue
				}
				retrievearray2:=breakstatements[from]
				retrievearray=append(retrievearray, retrievearray2...)
				breakstatements[lines[4][1:]]=retrievearray		
				continue		
			}

			if(len(lines)==5 || len(lines)==7){
				v:=string(lines[4][1:])
				if(strings.HasSuffix(v,",")){
					v=v[:len(v)-1]
				}
				retrievearray:=breakstatements[v]
				if(len(retrievearray)==0){
					breakstatements[lines[4][1:]]=[]string{}
					retrievearray:=breakstatements[v]
					retrievearray=append(retrievearray, from)
					breakstatements[v]=retrievearray					
				}else{
					retrievearray=append(retrievearray, from)
					breakstatements[v]=retrievearray
				}
			}else{
				v1:=string(lines[6][1:len(lines[6])-1])
				retrievearray:=breakstatements[v1]
				if(len(retrievearray)==0){
					breakstatements[v1]=[]string{}
					retrievearray=append(retrievearray, from)
					breakstatements[v1]=retrievearray
				}else{
					retrievearray=append(retrievearray, from)
					breakstatements[v1]=retrievearray
				}
				v2:=lines[8][1:]
				retrievearray1:=breakstatements[v2]
				if(len(retrievearray1)==0){
					breakstatements[v2]=retrievearray1
					retrievearray1=append(retrievearray1, from)
					breakstatements[v2]=retrievearray1					

				}else{
					retrievearray1=append(retrievearray1, from)
					breakstatements[v2]=retrievearray1
				}
			}
			continue
		}else if(strings.HasSuffix(lines[0],":")){
			value:=string(lines[0])
			from=value[:len(value)-1]
			from=from+" @"
			continue
		}else if(strings.HasSuffix(from," @")){
			from=from[:len(from)-2]
			if(string(lines[2])=="br"){
				from=from[:len(from)-2]
				retrievearray:=breakstatements[lines[4][1:]]
				if(len(retrievearray)==0){
					breakstatements[lines[4][1:]]=[]string{}
					retrievearray2:=breakstatements[from]
					retrievearray=breakstatements[lines[4][1:]]
					retrievearray=append(retrievearray, retrievearray2...)
					breakstatements[lines[4][1:]]=retrievearray
					continue
				}
				retrievearray2:=breakstatements[from]
				retrievearray=append(retrievearray, retrievearray2...)
				breakstatements[lines[4][1:]]=retrievearray		
				continue		
			}
			retrievearray:=breakvalues[from]
			if(len(retrievearray)==0){
				breakvalues[from]=[]string{}
				retrievearray=breakvalues[from]
			}
			to=strings.Join(lines," ")
			to=functionname+to
			retrievearray=append(retrievearray, to)
			breakvalues[from]=retrievearray
			addvertex(to)
			from=to
			to=""
			continue
		}else if(string(lines[4])=="call"){
			function:=lines[6]
			to=strings.Join(lines," ")
			to=functionname+to
			addvertex(to)
			connect(from,to)
			from=to
			index:=strings.Index(function,"(")
			function=function[0:index]
			retrievearray:=functions[function]
			if(len(retrievearray)!=0){
				from=nextfunction(from,function)
				continue
			}else{
				continue
			}
		}
		to=strings.Join(lines," ")
		to=functionname+to
		addvertex(to)
		connect(from,to)
		from=to
		to=""
	}
	fmt.Println(breakstatements)
	fmt.Println(breakvalues)
	resolvebreak(breakstatements,breakvalues)
	final:="@exit"
	addvertex(final)
	connect(from,final)
	anderfile, _ := os.Create("graph.gv")
	_ = draw.DOT(g, anderfile)	
}



func getfunctions(filepath string){
	file,err:=os.Open(filepath)
	if err!=nil{
		fmt.Println("Error opening the fiie:",err)
	}
	defer file.Close()
	scanner:=bufio.NewScanner(file)
	lines:=[][]string{}
	functionname:=""
	var flag int	
	for scanner.Scan(){
		words:=scanner.Text()
		line := strings.Split(words," ")
		if(line[0]=="define"){
			lines=append(lines,line)
			functionname=string(line[3])
			flag=1
		}else if(line[0]=="}"){
			if(flag==1){
				index:=strings.Index(functionname,"(")
				functionname=functionname[:index]
				functions[functionname]=[][]string{}
				retrievearray:=functions[functionname]
				retrievearray=append(retrievearray, lines...)
				functions[functionname]=retrievearray
			}
			emptyarr:=[][]string{}
			lines=emptyarr
			flag=0
		}else if(flag==1){
			lines= append(lines,line )
		}
	}
}




func main(){
	fmt.Println("We are going to generate Interprocedural Control Flow Graph for a given LLVM IR file")
	// Filepath of the LLVM IR File
	filepath:="/home/bala/memoryleakproject/icfg"
	irfiles:=readingirfiles(filepath)
	for _,files:=range(irfiles){
		fmt.Println(files)
		getfunctions(files)
		fmt.Println(functions)
		generategraph()

	}
}

///home/bala/memoryleakproject/icfg