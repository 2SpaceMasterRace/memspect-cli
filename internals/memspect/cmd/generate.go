/*
Copyright © 2024 NAME HERE <EMAIL ADDRESS>

*/
package cmd

import (
	"fmt"
	"os"
	"os/exec"
	"path/filepath"
	"sync"
	"strings"
	"github.com/spf13/cobra"
)

// generateCmd represents the generate command
var generateCmd = &cobra.Command{
	Use:   "generate",
	Short: "A brief description of your command",
	Long: `A longer description that spans multiple lines and likely contains examples
and usage of using your command. For example:

Cobra is a CLI library for Go that empowers applications.
This application is a tool to generate the needed files
to quickly create a Cobra application.`,
	Run: func(cmd *cobra.Command, args []string) {
		operation := args[0]
		path,_:=cmd.Flags().GetString("filepath")
		pngfordot,_:=cmd.Flags().GetString("png")
		if(operation=="ircode"){
			if path==""{
				fmt.Println("Generating",operation,"for files available in current working directory")
				path,err:=os.Getwd()
				if err!=nil{
					fmt.Println("Error while getting current directory:",err)
				}else{
					fmt.Println("Current Directory:",path)
				}
				generateircode(path)

			}else{
				fmt.Println("Generating",operation,"for files specified in location:",path)
				generateircode(path)
			}
		}else if (operation=="mdg"){
			if path==""{
				fmt.Println("Generating",operation,"for files available in current working directory")
				path,err:=os.Getwd()
				if err!=nil{
					fmt.Println("Error while getting current directory:",err)
				}else{
					fmt.Println("Current Directory:",path)
				}
				generatedotfiles(path)

			}else{
				fmt.Println("Generating",operation,"for files specified in location:",path)
				generatedotfiles(path)
			}
			if(pngfordot=="y"){
				generatepngfiles()
			}
		}

	},
}

func init() {
	rootCmd.AddCommand(generateCmd)
	generateCmd.Flags().String("filepath","","Either C File Path or IR File Path")
	generateCmd.Flags().String("png","","Specify y to generate png file for the .dot files")

	// Here you will define your flags and configuration settings.

	// Cobra supports Persistent Flags which will work for this command
	// and all subcommands, e.g.:
	// generateCmd.PersistentFlags().String("foo", "", "A help for foo")

	// Cobra supports local flags which will only run when this command
	// is called directly, e.g.:
	// generateCmd.Flags().BoolP("toggle", "t", false, "Help message for toggle")
}


func generateircode(directory string){
	fmt.Println("Directory:",directory)
	list_C_files := make([]string, 0)

	err:= filepath.Walk(directory, func(path string, info os.FileInfo, err error) error {
		if err != nil {
			return err
		}

		if filepath.Ext(path) == ".c" {
			list_C_files = append(list_C_files, path)
		}
		return nil

	})
	length:=len(list_C_files)
	if length==0{
		fmt.Println("Can't find any C files in the directory")
		return
	}
	if err != nil {
		fmt.Println("Error in walking folder : ", err)
		return 
	}
	var cfilepath []string
	var waitGroupBuffer sync.WaitGroup

	for _, cFile := range list_C_files {
		waitGroupBuffer.Add(1)

		go func(cFile string) {
			defer waitGroupBuffer.Done()
			trimmed := filepath.Base(cFile)[:len(filepath.Base(cFile))-2]
			irFilePath := filepath.Join(filepath.Dir(cFile), trimmed+".ll")
			cfilepath=append(cfilepath,irFilePath)
			cmd := exec.Command("clang", "-S", "-emit-llvm", cFile,"-o",irFilePath)
			err = cmd.Run()
			if err != nil {
				fmt.Printf("Error generating IR for %s: %s\n", cFile, err)
			} else {
				fmt.Printf("Generated IR code sucessfully for %s: %s\n", cFile, irFilePath)
			}
		}(cFile)
	}
	waitGroupBuffer.Wait()
}

func generatedotfiles(irFilepath string){
	list_ll_files := make([]string, 0)

	err:= filepath.Walk(irFilepath, func(path string, info os.FileInfo, err error) error {
		if err != nil {
			return err
		}

		if filepath.Ext(path) == ".ll" {
			list_ll_files = append(list_ll_files, path)
		}
		return nil

	})
	length:=len(list_ll_files)
	if length==0{
		fmt.Println("Can't find any IR files in the directory")
		return
	}
	if err != nil {
		fmt.Println("Error in walking folder : ", err)
		return 
	}
	for _, llFile := range list_ll_files {
		cmd := exec.Command("opt", "-dot-cfg", "-disable-output", "-enable-new-pm=0", llFile)
		err1:=cmd.Run()
		if err1!=nil{
			fmt.Println("Cannot execute the command")
			fmt.Println("Error:",err)
		}else{
			fmt.Println(".dot files has been generated")
		}
	}
}

func availabldotfiles()([]string,error){

	dotfiles := exec.Command("ls","-a")
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
			continue
		}else{
			fmt.Println("PNG file has been generated for ",file)
		}
	}	
}
