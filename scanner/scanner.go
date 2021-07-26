package main

import (
	"fmt"
	"github.com/fatih/color"
	"io/ioutil"
)

type Template struct {
	 FileName string
	 Content string
}

func ScanTemplates(dir string) []Template {
	files,err := ioutil.ReadDir(dir)
	if err != nil {
		color.Red("this dir doesn't exist:", dir)
	}

	for _, file := range files {
		fullPath := Full(dir, file.Name())
		fmt.Println(fullPath)
		if file.IsDir() {
			color.Blue("%s is a dir!, scanning further", fullPath)
			ScanTemplates(fullPath)
		}
	}

	return []Template{
		{
			FileName: "t1",
			Content:  "content",
		},
	}
}


func Full(dir string, path string) string {
	last := dir[len(dir)-1:]
	middle := ""

	if last != "/" {
		middle = "/"
	}
	return dir + middle + path
}