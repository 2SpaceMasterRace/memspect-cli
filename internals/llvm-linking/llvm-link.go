package main

import (
	"fmt"
	"os"
	"os/exec"
	"path/filepath"
	"sync"
)

func main() {
	workingDirectory, err := os.Getwd()
	if err != nil {
		fmt.Println("Cannot get working directory : ", err)
		return
	}

	list_C_files := make([]string, 0)

	err = filepath.Walk(workingDirectory, func(path string, info os.FileInfo, err error) error {
		if err != nil {
			return err
		}

		if filepath.Ext(path) == ".c" {
			list_C_files = append(list_C_files, path)
		}
		return nil

	})

	if err != nil {
		fmt.Println("Error in walking folder : ", err)
		return
	}

	var waitGroupBuffer sync.WaitGroup

	for _, cFile := range list_C_files {
		waitGroupBuffer.Add(1)

		go func(cFile string) {
			defer waitGroupBuffer.Done()

			irFilePath := filepath.Join(filepath.Dir(cFile), filepath.Base(cFile)+".ll")

			cmd := exec.Command("clang", "-S", "-emit-llvm", cFile)
			err = cmd.Run()
			if err != nil {
				fmt.Printf("Error generating IR for %s: %s\n", cFile, err)
			} else {
				fmt.Printf("Generate IR code sucessfully for %s: %s\n", cFile, irFilePath)
			}
		}(cFile)
	}
	waitGroupBuffer.Wait()
}
