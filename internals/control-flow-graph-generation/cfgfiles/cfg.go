package main

import (
	"fmt"
	"os/exec"
	"strings"
)



func generatedotfiles(llvmpath string){

	cmd := exec.Command("opt", "-dot-cfg", "-disable-output", "-enable-new-pm=0", llvmpath)
	err:=cmd.Run()
	if err!=nil{
		fmt.Println("Cannot execute the command")
		fmt.Println("Error:",err)
	}else{
		fmt.Println(".dot files has been generated")
	}
}

func availabldotfiles()([]string,error){

	dotfiles := exec.Command("ls", "-a")
	grepCmd := exec.Command("grep", ".dot")
	grepCmd.Stdin, _ = dotfiles.StdoutPipe()
	dotfiles.Start()
	dotFilePath, _ := grepCmd.Output()
	dotfiles.Wait()
	fileList := strings.Split(string(dotFilePath), "\n")
	return fileList,nil
}

func generatepngfiles(){

	fileList,_:=availabldotfiles()
	fmt.Println("List of dot files:")
	for _, file := range fileList {
		pngcmd:=exec.Command("dot","-Tpng","-o",file+".png",file)
		err:=pngcmd.Run()
		if(err!=nil){
			fmt.Println("PNG files hasn't been generated for ",file)
		}else{
			fmt.Println("PNG file has been generated for ",file)
		}
	}	
}

func cfg(llvmpath string){
	fmt.Println(llvmpath)
	generatedotfiles(llvmpath)
	generatepngfiles()
}
