extends CharacterBody2D
@onready var sprite = $OrcSprite
var run_speed = 20
enum state {
	idle, 
	walk, 
	attack,
	chase
}
var current_state = state.idle
var chase = false
var target_player = null  # Changed from 'player' to 'target_player'

func updateState(new_state):
	current_state = new_state
	match current_state:
		state.idle:
			sprite.play("idle")
		state.walk:
			sprite.play("walk")
		state.attack:
			sprite.play("attack")

func _ready() -> void:
	updateState(state.idle)
	# No longer need to get first player in group

func _process(delta: float) -> void:
	if chase and target_player:
		velocity = position.direction_to(target_player.position) * run_speed
		move_and_slide()

func _on_initiate_chase_body_entered(body: Node2D) -> void:
	# Check if the body is in the Players group
	if body.is_in_group("Players"):
		target_player = body
		updateState(state.walk)
		chase = true

func _on_initiate_chase_body_exited(body: Node2D) -> void:
	# Only stop chasing if the exiting body is our current target
	if body == target_player:
		chase = false
		target_player = null
		updateState(state.idle)

func _on_initiate_attack_body_entered(body: Node2D) -> void:
	# Only attack if this is our current target
	if body == target_player:
		updateState(state.attack)

func _on_initiate_attack_body_exited(body: Node2D) -> void:
	# Only change state if the exiting body is our current target
	if body == target_player:
		updateState(state.walk)
