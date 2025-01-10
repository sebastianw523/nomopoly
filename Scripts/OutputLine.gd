extends Control


onready var scrollBar = $List.get_v_scroll()

func _ready():
	pass

func set_text(text):
	$List.add_item(text)
	yield(get_tree().create_timer(0.01), "timeout")
	scrollBar.value = scrollBar.max_value
