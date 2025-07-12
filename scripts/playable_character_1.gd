extends CharacterBody2D

@onready var character_selector = get_node("../../character_selector")
@onready var sprite = $unit_sprite
@onready var attack_range = get_node("attack_range")

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
		state.attack:
			sprite.play("attack")
		state.walk:
			sprite.play("walk")
	
func _physics_process(delta):
	updateAnimation(currentState)
	
	if attack_range.has_overlapping_bodies():
		updateAnimation(state.attack)
	
	if Input.is_action_just_pressed("left_mouse"):
		if character_selector.active == 1:
			click_position = get_global_mouse_position()
			updateAnimation(state.walk)
		
	if position.distance_to(click_position) > 3:
		target_position = (click_position - position).normalized()
		velocity = target_position * speed
		move_and_slide() 
	elif currentState != state.attack:
		updateAnimation(state.idle)

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if Input.is_action_just_pressed("left_mouse"):
		print("selected this unit lol")
