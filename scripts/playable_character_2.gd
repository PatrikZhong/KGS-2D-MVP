extends CharacterBody2D

@onready var sprite = $AnimatedSprite2D
@onready var character_selector = get_node("../../character_selector")
@onready var area2d = $Area2D

var speed = 500
var click_position = Vector2()
var target_position = Vector2()
var currentState = state.idle

enum state {
	idle,
	walk,
	attack
}

func _ready():
	updateAnimation(currentState)

func updateAnimation(input: state):
	currentState = input
	match currentState:
		state.idle:
			sprite.play("idle")
		state.walk:
			sprite.play("walk")
		state.attack:
			sprite.play("attack")
	1
func _physics_process(delta):
	updateAnimation(currentState)
	
	if area2d.has_overlapping_areas():
		print("OVERLAPPING!")
	
	print(area2d.get_overlapping_areas())
	
	if Input.is_action_just_pressed("left_mouse"):
		if character_selector.active == 2:
			click_position = get_global_mouse_position()
		
	if position.distance_to(click_position) > 3:
		target_position = (click_position - position).normalized()
		velocity = target_position * speed
		updateAnimation(state.walk)
		move_and_slide() 
	else:
		updateAnimation(state.idle)
