extends CharacterBody2D

@onready var character_selector = get_parent()
@onready var attack_range = get_node("attack_range")
@onready var attack_timer = get_node("Timer")
@onready var hp_bar = get_node("TextureProgressBar")
@onready var sprite = $unit_sprite

var speed = 350
var click_position = Vector2()
var target_position = Vector2()
var current_state = state.idle

var health = 100
var can_attack = true

enum state {
	idle,
	walk,
	attack,
	death
}


func take_damage(damage: int):
	health = health - damage
	hp_bar.value = health

	if health <= 0:
		updateAnimation(state.death)
		queue_free()

func _ready():
	updateAnimation(current_state)
	hp_bar.value = health

func updateAnimation(input: state):
	current_state = input
	match current_state:
		state.idle:
			sprite.play("idle")
		state.attack:
			sprite.play("attack")
		state.walk:
			sprite.play("walk")
		state.death:
			sprite.play("death")
	
func _physics_process(delta):
	
	updateAnimation(current_state)
	
	if Input.is_action_just_pressed("left_mouse"):
		if character_selector.active == 2:
			click_position = get_parent().to_local(get_global_mouse_position())
		
	if position.distance_to(click_position) > 5:
		target_position = (click_position - position).normalized()
		velocity = target_position * speed
		updateAnimation(state.walk)
		move_and_slide()
		if velocity.x < 0:
			sprite.flip_h = true
		elif velocity.x > 0:
			sprite.flip_h = false
	elif current_state != state.attack:
		updateAnimation(state.idle)
		
	if attack_range.has_overlapping_bodies():
		updateAnimation(state.attack)
		if can_attack:
			can_attack = false
			attack_timer.start()
			for i in attack_range.get_overlapping_bodies():
				i.take_damage(10)
	elif current_state != state.walk:
		updateAnimation(state.idle)

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if Input.is_action_just_pressed("left_mouse"):
		print("selected this unit lol")

func _on_timer_timeout() -> void:
	can_attack = true
