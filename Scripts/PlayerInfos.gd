extends Control

var lastPlayerIndex = 0

func setActivePlayerIndicator(playerIndex):
	get_child(lastPlayerIndex).setInactive()
	get_child(playerIndex).setActive()
	lastPlayerIndex = playerIndex


func setInsolvent(playerIndex):
	get_child(playerIndex).setInsolvent()
