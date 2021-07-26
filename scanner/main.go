package main

import (
	"flag"
	"github.com/fatih/color"
)

func main() {
	d := flag.String("d", "./", "scanner -d dir/or/your/template")
	flag.Parse()
	color.Cyan("scanning:%s", *d)
	ScanTemplates(*d)
}
