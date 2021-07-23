package smarty

import (
	"fmt"
	"io/ioutil"
	"regexp"
	"strings"
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

func Parse(html string, vars map[string]interface{}) string {
	rule := `[{]{2}[$][a-zA-Z_]+[a-zA-Z0-9_]+[}]{2}`
	r, _ := regexp.Compile(rule)
	found := r.FindAllString(html, -1)
	for _, f := range found {
		key:= getKey(f)
		if val, ok := vars[key]; ok {
			krule := `[{]{2}[$]` + key + `+[}]{2}`
			kr, _ := regexp.Compile(krule)
			html = kr.ReplaceAllString(html, fmt.Sprintf("%v", val))
		}
	}
	return html
}

func getKey(matched string) string {
	matched = strings.Replace(matched, "{{", "", -1)
	matched = strings.Replace(matched, "}}", "", -1)
	return strings.Replace(matched, "$", "", 1)
}

func (s *Smarty) Render(fileName string)  string {
	f, err := ioutil.ReadFile(fmt.Sprintf("templates/%s.tpl", fileName))
	if err != nil {
		panic(err)
	}
	return Parse(s.Inflate(string(f)), s.vars)
}

func (s *Smarty) Inflate(html string) string {
	rule := ``
	r,_ := regexp.Compile(rule)
	all := r.FindAllString(html, -1)
	for _, s:= range all {
		fmt.Println(s)
	}
	return html
}