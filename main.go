package main

import (
	"fmt"
	"github.com/borankux/gosmarty/smarty"
)

func main() {
	s := smarty.Smarty{}
	s.Assign("message", "This is the message")
	s.Assign("subtitle", "this is the subtitle")
	s.Assign("age", 28)
	rendered := s.Render("main")
	fmt.Println(rendered)
}