package main

import (
	"fmt"
	"github.com/borankux/gosmarty/smarty"
)

func main() {
	s := smarty.Smarty{Config: &smarty.Config{
		TemplateDir: "templates",
	}}
	rendered := s.Render("include-file")
	fmt.Println(rendered)
}