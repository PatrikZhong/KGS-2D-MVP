extends Node2D

var play_button = null
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	play_button = get_node("AnimatedSprite2D")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _is_sprite_clicked(sprite: AnimatedSprite2D, mouse_pos: Vector2) -> bool:
	var texture = sprite.sprite_frames.get_frame_texture(sprite.animation, sprite.frame)
	if texture == null:
		return false
		
	var size = texture.get_size()
	var local_mouse_pos = sprite.to_local(mouse_pos)
	var half_size = (size * 0.5) * sprite.scale
			
	return abs(local_mouse_pos.x) <= half_size.x and abs(local_mouse_pos.y) <= half_size.y
	
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			var mouse_pos = get_global_mouse_position()
			if _is_sprite_clicked(play_button, mouse_pos):
				if (Globals.done_collumns[-1]) == 0:
					get_tree().change_scene_to_file("res://scenes/test_scene.tscn")
				else:
					get_tree().change_scene_to_file("res://scenes/rasmus_playground.tscn")
