extends KinematicBody2D

var icons = [
	preload("res://Assets/PlayerIcons/Player1.png"),
	preload("res://Assets/PlayerIcons/Player2.png"),
	preload("res://Assets/PlayerIcons/Player3.png"),
	preload("res://Assets/PlayerIcons/Player4.png")
]

var colors = [
	Color("#00ff5b"),
	Color("#0089ff"),
	Color("#ff0081"),
	Color("#ff9800")
]

onready var playerNumber = get_index() + 1
onready var playerName = "Player " + str(playerNumber)
var color
var money = 30000
var boardPosition = 0
var consecutiveDoubles = 0
var inJail = false 
var roundsInJail = 0
var isInsolvent = false

onready var waypoints = $"../../map/Waypoints"
onready var jailWaypoint = $"../../map/Jail"
onready var dice = $"../../map/dice"
onready var diceButton = $"../../map/dice/Button"
onready var interaction = $"../../UI/Interaction"
onready var outputLine = $"../../UI/OutputLine"

onready var target = position
var speed = 15


func _ready():
	color = colors[playerNumber - 1]
	$CollisionShape2D/Sprite.set_texture(icons[playerNumber - 1])


# warning-ignore:unused_argument
func _physics_process(delta):
	
	if inJail == true:
		target = jailWaypoint.get_global_position()
	else:
		target = waypoints.get_child(boardPosition).position
	
	if waypoints.get_child(boardPosition)._numberOfPlayers > 1:
		match playerNumber:
			2:
				target += Vector2(0,-30)
			3:
				target += Vector2(0,30)
			4:
				target += Vector2(30,0)
	var motion = (target - position).normalized() * speed
	if position == target:
		return
	elif motion.length() > position.distance_to(target):
		position = target
	else:
		position += motion


func play_turn():
	$"../../UI/PlayerInfos/VBoxContainer".setActivePlayerIndicator(get_index())

	if inJail == true:
		roundsInJail += 1
		if roundsInJail < 3:
			yield(interaction.decision\
			("Möchtest du dich für 1000 DM aus dem Gefängnis freikaufen? (noch " + str(3 - roundsInJail) + " Runden)"),\
			"completed")
			if interaction._isYes == true:
				money -= 1000
				outputLine.set_text(playerName + " hat sich für 1000 DM aus dem Gefängnis freigekauft.")
				leave_jail()
			else:
				outputLine.set_text(playerName + " hat sich nicht aus dem Gefängnis freigekauft.")
		
	consecutiveDoubles = 0
	while true:
		if inJail == true and roundsInJail == 0:   #Wenn spieler in dieser Runde ins Gefängnis kam
			break
			
		yield(diceButton, "pressed")
		yield(dice.roll(), "completed")
		
		#Spieler geht ins gefängnis wenn drei Pasche hintereinander
		if dice.doubles == true:
			consecutiveDoubles += 1
			if consecutiveDoubles == 3:
				yield(interaction.okButton("Du musst in das Gefängnis gehen, weil du drei Pasche hintereinander hattest."), "completed")
				inJail = true
				break
		
		if inJail == true:
			if dice.doubles == true:
				leave_jail()
				yield(go_number(dice.value), "completed")
			else:   #Wenn Spieler keinen Pasch hat
				if roundsInJail == 3:
					yield(interaction.okButton("Du musst 1000 DM zahlen da du drei Runden lang keinen Pasch gewürfelt hast."), "completed")
					outputLine.set_text(playerName + " musste sich für 1000 DM aus dem Gefängnis freikaufen.")
					leave_jail()
					yield(go_number(dice.value), "completed")
		
		else:   #Wenn Spieler nicht im Gefängnis ist
			yield(go_number(dice.value), "completed")
			
		if dice.doubles == false or money < 0:
			break
	
	if money < 0:
		yield(interaction.okButton("Du hast kein Geld mehr! Das Spiel ist für dich zu Ende."), "completed")
		isInsolvent = true
		$"../../UI/PlayerInfos".setInsolvent(get_index())
		visible = false
		outputLine.set_text(playerName + " ist insolvent gegangen.")
		for field in waypoints.get_children():
			if field._type == "utility" or field._type == "street" or field._type == "railroad":
				if field._owner == self:
					field._owner = null
					field.get_child(0).visible = false



func leave_jail():
	roundsInJail = 0
	boardPosition = 10
	inJail = false


func go_number(number):
	boardPosition += number
	if boardPosition > 39:
		boardPosition -= 40
		
	if boardPosition == 0:   #Wenn Spieler auf Los ist
		yield(interaction.okButton("Du erhältst 8000 DM, weil du auf LOS gelandet bist."), "completed")
		money += 8000   #Zahle Spieler 8000
		outputLine.set_text(playerName + " hat 8000 DM erhalten weil er auf LOS gelandet ist")
	elif boardPosition - number < 0:   #Wenn Spieler Über Los gegangen ist
		yield(interaction.okButton("Du erhältst 4000 DM weil du über LOS gegangen bist."), "completed")
		money += 4000   #Zahle Spieler 4000
		outputLine.set_text(playerName + " hat 4000 DM erhalten weil er über LOS gegangen ist.")
	yield(waypoints.get_child(boardPosition).player_on_field(self), "completed")


func go_to_field(targetField):
	if boardPosition <= targetField:
		yield(go_number(targetField - boardPosition), "completed")
	else:
		yield(go_number(40 + targetField - boardPosition), "completed")
