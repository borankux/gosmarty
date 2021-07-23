package smarty

const (
	RULE_INCLUDE string = `(\{)(\s+|)[a-zA-Z0-9]+\s+file(\s+|)=(\s+|)\"([a-zA-Z-\/])+\"(\s+|)\}`
	RULE_VARIABLE string = `[{]{2}[$][a-zA-Z_]+[a-zA-Z0-9_]+[}]{2}`
)
