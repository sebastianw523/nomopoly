extends Node

onready var activeCharacter = get_child(0)

var runGame = true

func _ready():
	if Global.playerCount > 2:
		var playerDuplicate
		var playerInfoDuplicate
		
		for i in Global.playerCount - 2:
			playerDuplicate = get_child(0).duplicate()
			playerInfoDuplicate = $"../UI/PlayerInfos/VBoxContainer/Control".duplicate()
			add_child(playerDuplicate)
			$"../UI/PlayerInfos/VBoxContainer".add_child(playerInfoDuplicate)
			
	play_turn()

func play_turn():
	while runGame:
		if activeCharacter.isInsolvent == false:
			yield(activeCharacter.play_turn(), "completed")
		var newIndex = (activeCharacter.get_index() + 1) % get_child_count()
		activeCharacter = get_child(newIndex)
