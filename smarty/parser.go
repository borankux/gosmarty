package smarty

import (
	"fmt"
	"regexp"
	"strings"
)

func Parse(html string, vars map[string]interface{}) string {
	rule := RULE_VARIABLE
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
