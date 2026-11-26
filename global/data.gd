extends Node

signal shire_rep_changed

var shire_rep := 0
var library_standard := 10
var genres := {
	1 : "dragon",
	2 : "mountain",
	3 : "crown",
	4 : "plant",
	5 : "bread",
	6 : "hammer",
	7 : "heart",
	8 : "sword",
}

func increse_shire_rep(amount):
	shire_rep += amount
	emit_signal("shire_rep_changed")
