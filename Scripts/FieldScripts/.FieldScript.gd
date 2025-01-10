extends Position2D


var _type
var _numberOfPlayers = 0
onready var dice = $"../../dice"
onready var turnQueue = $"../../../TurnQueue"
onready var Interaction = $"../../../UI/Interaction"
onready var OutputLine = $"../../../UI/OutputLine"

func _physics_process(delta):
	var _number = 0
	for player in turnQueue.get_children():
		if player.boardPosition == get_index() and player.isInsolvent == false:
			_number += 1
	_numberOfPlayers = _number

func player_on_field(_player):
	yield(get_tree(), "idle_frame")   #verhindert Fehlermeldung wenn für die funktion geyielded wird
	return
