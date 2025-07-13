extends Node

@onready var active = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	11
	if Input.is_action_just_pressed("ui_1"):
		print("selected unit 1")
		active = 1
	elif Input.is_action_just_pressed("ui_2"):
		print("selected unit 2")
		active = 2
	elif Input.is_action_just_pressed("ui_3"):
		print("selected unit 2")
		active = 3
