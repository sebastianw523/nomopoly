extends Node

var value = 0
var doubles = false

onready var dice1 = $"dice1"
onready var dice2 = $"dice2"

func _ready():
	pass

func roll():
	dice1.roll()
	yield(dice2.roll(), "completed")
	value = dice1.finalNumber + dice2.finalNumber
	if dice1.finalNumber == dice2.finalNumber:
		doubles = true
	else:
		doubles = false
