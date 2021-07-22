package smarty

import (
	"fmt"
	"io/ioutil"
)

type Smarty struct {
	vars map[string]interface{}
}

func (s *Smarty) Assign(key string, val interface{}) {
	if s.vars == nil {
		s.vars = make(map[string]interface{})
	}
	s.vars[key] = val
}

func (s *Smarty) Print() {
	for i:= range s.vars {
		fmt.Println(s.vars[i])
	}
}

func (s *Smarty) Render(fileName string)  string {
	f, err := ioutil.ReadFile(fmt.Sprintf("templates/%s.tpl", fileName))
	if err != nil {
		panic(err)
	}
	return Parse(string(f), s.vars)
}