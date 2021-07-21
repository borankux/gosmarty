package smarty

import "fmt"

type Smarty struct {
	vars []map[string]interface{}
}

func (s *Smarty) Assign(key string, val interface{}) {
	v := map[string]interface{} {
		key: val,
	}
	s.vars = append(s.vars, v)
}

func (s *Smarty) Print() {
	for i:= range s.vars {
		fmt.Println(s.vars[i])
	}
}