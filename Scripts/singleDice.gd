extends Sprite

var diceSide = [
	preload("res://Assets/DiceSides/Side1.png"),
	preload("res://Assets/DiceSides/Side2.png"),
	preload("res://Assets/DiceSides/Side3.png"),
	preload("res://Assets/DiceSides/Side4.png"),
	preload("res://Assets/DiceSides/Side5.png"),
	preload("res://Assets/DiceSides/Side6.png")
]
var finalNumber = 0
var rng = RandomNumberGenerator.new()

func _ready():
	pass

func roll():
	var randomNumber = 0
	rng.randomize()
	
	for n in 16:
		randomNumber = rng.randi_range(0,5)
		set_texture(diceSide[randomNumber])
		yield(get_tree().create_timer(0.1), "timeout")
	finalNumber = randomNumber + 1
