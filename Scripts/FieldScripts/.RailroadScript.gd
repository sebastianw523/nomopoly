extends "res://Scripts/FieldScripts/.FieldScript.gd"


var _owner
var _name
var _price = 4000
var _rent

func _ready():
	_type = "railroad"

func player_on_field(_player):
	yield(get_tree(), "idle_frame")   #verhindert Fehlermeldung wenn für die funktion geyielded wird
	if _owner == null:
		if _player.money >= _price:
			yield(Interaction.decision("Möchtest du den " + _name + " für " + str(_price) +  " kaufen?"), "completed")
			if Interaction._isYes == true:
				_player.money -= _price
				_owner = _player
				$ColorRect.color = _player.color
				$ColorRect.visible = true
				OutputLine.set_text(_player.playerName + " hat " + _name + " für " + str(_price) + " DM gekauft.")
			else:
				OutputLine.set_text(_player.playerName + " hat " + _name + " nicht gekauft.")
		else:
			OutputLine.set_text(_player.playerName + " hat nicht genug geld um " + _name + " zu kaufen")
	elif _owner == _player:
		OutputLine.set_text(_player.playerName + " musste keine Miete zahlen, weil er " + _name + " besitzt.")
	else:
		var _numberOfRailroads = 0
		for field in get_parent().get_children():
			if field._type == "railroad":
				if _owner == field._owner:
					_numberOfRailroads += 1
		_rent = 500 * pow(2, _numberOfRailroads - 1)
		yield(Interaction.okButton("Du musst " + str(_rent) + " DM Miete an " + _owner.playerName + " zahlen."), "completed")
		_player.money -= _rent
		OutputLine.set_text(_player.playerName + " hat " + str(_rent) + " DM Miete an " + _owner.playerName + " gezahlt.")
