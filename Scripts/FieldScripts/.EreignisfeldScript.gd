extends "res://Scripts/FieldScripts/.FieldScript.gd"


func _ready():
	_type = "Ereignisfeld"

func player_on_field(_player):
	randomize()
	var randomNumber = randi() % 12
	match randomNumber:
		0:
			yield(Interaction.okButton("Ereigniskarte: Gehe 3 Felder zurück."), "completed")
			OutputLine.set_text(_player.playerName + " ging drei Felder zurück.")
			yield(_player.go_number(-3), "completed")
		1:
			yield(Interaction.okButton("Ereigniskarte: Rücke vor bis zur Schlossallee."), "completed")
			OutputLine.set_text(_player.playerName + " rückte vor bis zur Schlossallee.")
			yield(_player.go_to_field(39), "completed")
		2:
			yield(Interaction.okButton("Ereigniskarte: Rücke vor bis auf LOS."), "completed")
			OutputLine.set_text(_player.playerName + " rückte vor bis auf LOS.")
			yield(_player.go_to_field(0), "completed")
		3:
			yield(Interaction.okButton("Ereigniskarte: Gehe in das Gefängnis! Begib Dich direkt dorthin. Gehe nicht über LOS."), "completed")
			OutputLine.set_text(_player.playerName + " ging in das Gefängnis.")
			_player.inJail = true
		4:
			yield(Interaction.okButton("Ereigniskarte: Mache einen Ausflug zum Südbahnhof. Wenn Du über LOS kommst, ziehe 4000 DM ein."), "completed")
			OutputLine.set_text(_player.playerName + " machte einen Ausflug zum Südbahnhof.")
			yield(_player.go_to_field(5), "completed")
		5:
			yield(Interaction.okButton("Ereigniskarte: Strafe für zu schnelles Fahren: 300 DM"), "completed")
			OutputLine.set_text(_player.playerName + " zahlte 300 DM Strafe für zu schnelles Fahren.")
			_player.money -= 300
		6:
			yield(Interaction.okButton("Ereigniskarte: Die Bank zahlt Dir eine Dividende: 1000 DM"), "completed")
			OutputLine.set_text(_player.playerName + " erhielt 1000 DM Dividende von der Bank. und ich schreibe einen text")
			_player.money += 1000
		7:
			yield(Interaction.okButton("Ereigniskarte: Miete und Anleihezinsen werden fällig. Die Bank zahlt Dir 3000 DM"), "completed")
			OutputLine.set_text(_player.playerName + " erhielt 3000 DM von der Bank.")
			_player.money += 3000
		8:
			yield(Interaction.okButton("Ereigniskarte: Rücke vor bis zum Opernplatz."), "completed")
			OutputLine.set_text(_player.playerName + " rückte vor bis zum Opernplatz.")
			_player.go_to_field(24)
		9:
			yield(Interaction.okButton("Ereigniskarte: Gehe zurück zur Badstraße."), "completed")
			OutputLine.set_text(_player.playerName + " ging zurück zur Badstraße.")
			_player.boardPosition = 1
			get_parent().get_child(1).player_on_field(_player)
		10:
			yield(Interaction.okButton("Ereigniskarte: Rücke vor bis zur Seestraße."), "completed")
			OutputLine.set_text(_player.playerName + " rückte vor bis zur Seestraße.")
			_player.go_to_field(11)
		11:
			yield(Interaction.okButton("Ereigniskarte: Die Bank zahlt Dir eine Dividende: 1000 DM"), "completed")
			OutputLine.set_text(_player.playerName + " erhielt 1000 DM Dividende von der Bank.")
			_player.money += 1000
