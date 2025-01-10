extends "res://Scripts/FieldScripts/.FieldScript.gd"


var _owner
var _name
var _color
var _price
var _rent

func _ready():
	_type = "street"

func player_on_field(_player):
	yield(get_tree(), "idle_frame")   #verhindert Fehlermeldung wenn für die funktion geyielded wird
	if _owner == null:
		if _player.money >= _price:
			yield(Interaction.decision("Möchtest du " + _name + " für " + str(_price) + " kaufen?"), "completed")
			if Interaction._isYes == true:
				_player.money -= _price
				_owner = _player
				$ColorRect.color = _player.color
				$ColorRect.visible = true
				OutputLine.set_text(_player.playerName + " hat " + _name + " für " + str(_price) +  " DM gekauft.")
			else:
				OutputLine.set_text(_player.playerName + " hat " + _name + " nicht gekauft.")
		else:
			OutputLine.set_text(_player.playerName + " hat nicht genug geld um " + _name + " zu kaufen")
	elif _owner == _player:
		OutputLine.set_text(_player.playerName + " musste keine Miete zahlen, weil er " + _name + " besitzt.")
	else:
		var _ownsAllStreets = true
		for field in get_parent().get_children():
			if field._type == "street":
				if field._color == _color:
					if field._owner != _owner:
						_ownsAllStreets = false
		var _newRent
		if _ownsAllStreets == true:
			_newRent = 2 * _rent
		else:
			_newRent = _rent
		yield(Interaction.okButton("Du musst DM " + str(_newRent) + ",- Miete an " + _owner.playerName + " zahlen."), "completed")
		_player.money -= _newRent
		_owner.money += _newRent
		OutputLine.set_text(_player.playerName + " hat " + str(_newRent) + " DM Miete an " + _owner.playerName + " gezahlt.")
