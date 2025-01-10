extends "res://Scripts/FieldScripts/.FieldScript.gd"


var _price


func player_on_field(_player):
	yield(Interaction.okButton("Du musst DM " + str(_price) + ",- Einkommensteuer zahlen."), "completed")
	_player.money -= _price
	OutputLine.set_text(_player.playerName + " hat DM " + str(_price) + ",- Steuer gezahlt")
