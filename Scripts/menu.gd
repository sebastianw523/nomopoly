extends Node2D


export var mainGameScene : PackedScene

var playerCount = 2

func _on_StartGameButton_pressed():
	get_tree().change_scene(mainGameScene.resource_path)
	Global.playerCount = playerCount


func _on_ExitButton_pressed():
	get_tree().quit()


func _on_MinusButton_pressed():
	if playerCount > 2:
		playerCount -= 1
		$MarginContainer/VBoxContainer/VBoxContainer/MarginContainer2/HBoxContainer/Label2.text = str(playerCount)


func _on_PlusButton_pressed():
	if playerCount < 4:
		playerCount += 1
		$MarginContainer/VBoxContainer/VBoxContainer/MarginContainer2/HBoxContainer/Label2.text = str(playerCount)
