extends CharacterBody2D
# Node references
@onready var attack_range = get_node("InitiateAttack")
@onready var chase_range = get_node("InitiateChase")
@export var run_speed: float = 100
@onready var sprite = get_node("OrcSprite")
var health = 100
@onready var hp_bar = $Label

# State management
enum State {
	IDLE, 
	WALK, 
	ATTACK,
	CHASE
}
var current_state = State.IDLE
var chase = false
var target_player = null
func take_damage(damage: int):
	health = health - damage
	hp_bar.text = str(health)

	if health <= 0:
		update_state(State.IDLE)
		queue_free()

func update_state(new_state: State):
	current_state = new_state
	match current_state:
		State.IDLE:
			if sprite:
				sprite.play("idle")
		State.WALK:
			if sprite:
				sprite.play("walk")
		State.ATTACK:
			if sprite:
				sprite.play("attack")
		State.CHASE:
			if sprite:
				sprite.play("walk")  

func _ready() -> void:
	if not sprite and has_node("AnimatedSprite2D"):
		sprite = ($AnimatedSprite2D)
	update_state(State.IDLE)

func _physics_process(delta: float) -> void:
	# Check conditions in priority order
	if attack_range.has_overlapping_bodies():
		chase = false
		update_state(State.ATTACK)
		#print("time to attack")
	elif chase_range.has_overlapping_bodies():
		chase = true
		target_player = chase_range.get_overlapping_bodies()[0]
		update_state(State.CHASE)
		#print("im chasing")
		# Move towards player

		velocity = global_position.direction_to(target_player.global_position) * run_speed
		move_and_slide()
	else:
		chase = false
		target_player = null
		update_state(State.IDLE)
		velocity = Vector2.ZERO
		#print("im chillin")
