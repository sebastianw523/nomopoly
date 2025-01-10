extends "res://Scripts/FieldScripts/.FieldScript.gd"


func _ready():
	_type = "special"

func player_on_field(_player):
	yield(Interaction.okButton("Gehe in das Gefängnis."), "completed")
	_player.inJail = true
	OutputLine.set_text(_player.playerName + " ging in das Gefängnis.")
	yield(get_tree().create_timer(0.01), "timeout")
