extends Control


var _labelMoney = 30000
onready var turnQueue = $"../../../../TurnQueue"

func _ready():
	$NameLabel.text = turnQueue.get_child(get_index()).playerName

func _physics_process(delta):
	var _playerMoney = turnQueue.get_child(get_index()).money
	$MoneyLabel.text = "DM " + str(_labelMoney)
	if _playerMoney != _labelMoney:
		if _labelMoney < _playerMoney and _labelMoney > _playerMoney -50:
			_labelMoney += 1
		if _labelMoney > _playerMoney and _labelMoney < _playerMoney +50:
			_labelMoney -= 1
		elif _labelMoney < _playerMoney:
			_labelMoney += 50
		elif _labelMoney > _playerMoney:
			_labelMoney -= 50

func setActive():
	$Indicator.color = Color("#00ff00")

func setInactive():
	if $Indicator.color != Color("#FF0000"):   #Wenn der Spieler nicht in Insolvenz ist
		$Indicator.color = Color("#a1a1a1")

func setInsolvent():
	$Indicator.color = Color("#FF0000")
