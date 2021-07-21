package main

import "github.com/borankux/gosmarty/smarty"

func main() {
	s := smarty.Smarty{}
	s.Assign("name", "MotherFucker")
	s.Assign("gender", "boy")
	s.Assign("gender", "boy")
	s.Print()
}