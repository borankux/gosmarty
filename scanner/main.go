package main

import (
	"flag"
)

func main() {
	d := *flag.String("d", "./", "scanner -d dir/or/your/template")
	flag.Parse()
	ScanTemplates(d)
}
