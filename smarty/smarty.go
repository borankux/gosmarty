package smarty

import (
	"fmt"
	"github.com/fatih/color"
	"io/ioutil"
	"regexp"
	"strings"
)

type Smarty struct {
	vars map[string]interface{}
	Config *Config
}

type Config struct {
	TemplateDir string
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
	return Parse(s.InflateFromFile(fileName), s.vars)
}

func (s *Smarty)loadTemplate(fileName string) string {
	templateDir := s.Config.TemplateDir
	color.Cyan("trying to load file %s/%s.tpl", templateDir, fileName)
	f, err := ioutil.ReadFile(fmt.Sprintf("%s/%s.tpl",templateDir, fileName))
	if err != nil {
		panic(err)
	}
	return string(f)
}

func getAttr(content string, attr string ) string {
	//group  (       1      )(       2         )( 3)
	rule := `(` + attr +`\s*\=\s*\")([a-zA-Z0-9\/\-.]*)(\")`
	r, err:= regexp.Compile(rule)
	if err != nil {
		return attr
	}

	matched := r.FindStringSubmatch(content)
	if len(matched) < 2 {
		color.Red("cannot find attribute:%s", attr)
		return attr
	}
	return r.FindStringSubmatch(content)[2]
}

func (s *Smarty) InflateFromFile(fileName string) string {
	html := s.loadTemplate(fileName)
	rule := RULE_INCLUDE
	r,_ := regexp.Compile(rule)
	groups := r.FindAllString(html, -1)
	if len(groups) > 0 {
		for _, group := range groups {
			file := getAttr(group, "file")
			inflated := s.InflateFromFile(file)
			html = strings.Replace(html, group, inflated, -1)
		}
	}
	return html
}