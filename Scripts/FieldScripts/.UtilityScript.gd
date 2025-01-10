extends "res://Scripts/FieldScripts/.FieldScript.gd"


var _owner
var _name
var _price
var _rent


func _ready():
	_type = "utility"


func player_on_field(_player):
	yield(get_tree(), "idle_frame")   #verhindert Fehlermeldung wenn für die funktion geyielded wird
	if _owner == null:
		if _player.money >= _price:
			yield(Interaction.decision("Möchtest du das " + _name + " für " + str(_price) +  " kaufen?"), "completed")
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
	else:
		var _numberOfUtilities = 0
		if _owner == get_parent().get_child(12)._owner:   #Elektrizitätswerk
			_numberOfUtilities += 1
		if _owner == get_parent().get_child(28)._owner:   #Wasserwerk
			_numberOfUtilities += 1
		if _numberOfUtilities == 1:
			_rent = dice.value * 80
		else:
			_rent = dice.value * 200
		yield(Interaction.okButton("Du musst " + str(_rent) + " DM Miete an " + _owner.playerName + " zahlen."), "completed")
		_player.money -= _rent
		_owner.money += _rent
		OutputLine.set_text(_player.playerName + " hat " + str(_rent) + " DM Miete an " + _owner.playerName + " gezahlt.")
