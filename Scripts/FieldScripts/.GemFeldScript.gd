extends "res://Scripts/FieldScripts/.FieldScript.gd"


func _ready():
	_type = "GemFeld"

func player_on_field(_player):
	randomize()
	var randomNumber = randi() % 14
	
	match randomNumber:
		0:
			yield(Interaction.okButton("Gemeinschaftskarte: Du hast in einem Kreuzworträtsel-Wettbewerb gewonnen. Ziehe 2000 DM ein."), "completed")
			_player.money += 2000
			OutputLine.set_text(_player.playerName + " gewann 2000 DM in einem Kreuzworträtsel-Wettbewerb.")
		1:
			yield(Interaction.okButton("Gemeinschaftskarte: Du erbst: 2000 DM"), "completed")
			_player.money += 2000
			OutputLine.set_text(_player.playerName + " hat 2000 DM geerbt.")
		2:
			yield(Interaction.okButton("Gemeinschaftskarte: Du erhältst auf Vorzugs-Aktien 7% Dividende: 900 DM"), "completed")
			_player.money += 900
			OutputLine.set_text(_player.playerName + " hat 900 DM Dividende erhalten.")
		3:
			yield(Interaction.okButton("Gemeinschaftskarte: Arzt-Kosten. Zahle: 1000 DM."), "completed")
			_player.money -= 1000
			OutputLine.set_text(_player.playerName + " zahlte 1000 DM Arztkosten.")
		4:
			yield(Interaction.okButton("Gemeinschaftskarte: Die Jahresrente wird fällig. Ziehe 2000 DM ein."), "completed")
			_player.money += 2000
			OutputLine.set_text(_player.playerName + " hat 2000 DM Jahresrente erhalten")
		5:
			yield(Interaction.okButton("Gemeinschaftskarte: Aus Lagerverkäufen erhältst Du: 500 DM"), "completed")
			_player.money += 500
			OutputLine.set_text(_player.playerName + " hat 500 DM aus Lagerverkäufen erhalten.")
		6:
			yield(Interaction.okButton("Gemeinschaftskarte: Bank-Irrtum zu Deinen Gunsten. Ziehe 4000 DM ein."), "completed")
			_player.money += 4000
			OutputLine.set_text(_player.playerName + " hat 4000 DM durch einen Bank-Irrtum erhalten.")
		7:
			yield(Interaction.okButton("Gemeinschaftskarte: Zahle Schulgeld: 3000 DM"), "completed")
			_player.money -= 3000
			OutputLine.set_text(_player.playerName + " hat 3000 DM Schulgeld gezahlt.")
		8:
			yield(Interaction.okButton("Gemeinschaftskarte: Zahle an das Krankenhaus: 2000 DM"), "completed")
			_player.money -= 2000
			OutputLine.set_text(_player.playerName + " hat 2000 DM an das Krankenhaus gezahlt.")
		9:
			yield(Interaction.okButton("Gemeinschaftskarte: Gehe in das Gefängnis! Begib Dich direkt dorthin. Gehe nicht über LOS."), "completed")
			_player.inJail = true
			OutputLine.set_text(_player.playerName + " ging durch das Gemeinschaftsfeld ins Gefängnis.")
		10:
			yield(Interaction.okButton("Gemeinschaftskarte: Du hast den 2. Preis in einer Schönheitskonkurrenz gewonnen. Ziehe 200 DM ein."), "completed")
			_player.money += 200
			OutputLine.set_text(_player.playerName + " gewann 200 DM in einer Schönheitskonkurrenz.")
		11:
			yield(Interaction.okButton("Gemeinschaftskarte: Einkommensteuer-Rückzahlung. Ziehe 400 DM ein."), "completed")
			_player.money += 400
			OutputLine.set_text(_player.playerName + " erhielt 400 DM Einkommensteuer-Rückzahlung.")
		12:
			yield(Interaction.okButton("Gemeinschaftskarte: Rücke vor bis auf LOS."), "completed")
			_player.boardPosition = 0
			_player.go_number(0)
			OutputLine.set_text(_player.playerName + " rückte vor bis auf LOS.")
		13:
			yield(Interaction.okButton("Gemeinschaftskarte: Es ist dein Geburtstag. Ziehe von jedem Spieler 1000 DM ein."), "completed")
			var amount = 0
			for givingPlayer in turnQueue.get_children():
				if givingPlayer != _player and givingPlayer.isInsolvent == false:
					givingPlayer.money -= 1000
					amount += 1000
			_player.money += amount
			OutputLine.set_text(_player.playerName + " hat " + str(amount) + " DM zum Geburtstag bekommen")
			
			#Fehlt: Du kommst aus dem Gefängnis frei,
			#		Straßenausbesserungen

	yield(get_tree().create_timer(0.01), "timeout")
	emit_signal("_finished")
