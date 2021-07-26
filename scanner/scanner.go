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

	for file := range files {
		fmt.Println(file)
	}

	return []Template{
		{
			FileName: "t1",
			Content:  "content",
		},
	}
}
