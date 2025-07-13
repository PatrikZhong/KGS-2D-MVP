extends CharacterBody2D

@onready var character_selector = get_parent()
@onready var sprite = $unit_sprite
@onready var attack_range = get_node("attack_range")
@onready var cooldown = $CooldownTimer
@onready var hp_bar = $Label

var speed = 500
var click_position = Vector2()
var target_position = Vector2()
var currentState = state.idle
var isRunning = false

var health = 100

enum state {
	idle,
	walk,
	attack
}

func take_damage(damage: int):
	health = health - damage
	hp_bar.text = str(health)
	
	print("YOU JUST TOOK ", damage, " DAMAGE! Remaining: ", health)
	if health < 0:
		queue_free()
	

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
	
	if Input.is_action_just_pressed("left_mouse"):
		if character_selector.active == 2:
			click_position = get_global_mouse_position()
		
	if position.distance_to(click_position) > 5:
		target_position = (click_position - position).normalized()
		velocity = target_position * speed
		updateAnimation(state.walk)
		move_and_slide()
		
		if velocity.x < 0:
			sprite.flip_h = true
		elif velocity.x > 0:
			sprite.flip_h = false
			
	elif currentState != state.attack:
		updateAnimation(state.idle)
		
	if attack_range.has_overlapping_bodies():
		updateAnimation(state.attack)
	elif currentState != state.walk:
		updateAnimation(state.idle)

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if Input.is_action_just_pressed("left_mouse"):
		print("selected this unit lol")
