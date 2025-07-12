extends CharacterBody2D

@onready var sprite = $AnimatedSprite2D
var run_speed = 5
enum state {
	idle, 
	walk, 
	attack,
	chase
}
var current_state = state.idle
var chase = false
var player = null

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
	#player = get_parent()
	player = get_tree().get_first_node_in_group("Players")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if chase:
		velocity = position.direction_to(player.position) * run_speed
		move_and_slide()
	
func _on_initiate_chase_body_entered(body: Node2D) -> void:
	updateState(state.walk) # Replace with function body.
	
	chase = true

func _on_initiate_chase_body_exited(body: Node2D) -> void:
	chase = false
	updateState(state.idle)

func _on_initiate_attack_body_entered(body: Node2D) -> void:
	updateState(state.attack) # Replace with function body.

	
func _on_initiate_attack_body_exited(body: Node2D) -> void:
	updateState(state.walk)
