extends Node2D

@onready var node1 = get_node("level1")
@onready var node2 = get_node("level2")
@onready var node3 = get_node("level3")
@onready var node4 = get_node("level4")
@onready var node5 = get_node("level5")

@onready var nodes = [node1, node2, node3, node4, node5]

@onready var play_button = get_node("play_button")

var selected = null

@onready var layers = {
	1: [node1],
	2: [node2, node3],
	3: [node4],
	4: [node5],
}

signal path_selected

# Called when the node enters the scene tree for the first time.
func _ready() -> void:		
	play_button.visible = false
	
	var next_layers = layers.get(Globals.done_collumns[-1] + 1)
	
	if next_layers != null:
		for node in next_layers:
			node.frame = 1
	
	for column in Globals.done_collumns.slice(1, Globals.done_collumns.size()):
		for node in layers[column]:
			node.modulate = Color(0.5, 0.5, 0.5)
	
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
			for node in nodes:
				if _is_sprite_clicked(node, mouse_pos):
					var next_layer = Globals.done_collumns[-1] + 1
					if layers.has(next_layer) and node in layers[next_layer]:
						node.modulate = Color(0.6, 1.0, 0.6)
						if selected != null and selected != node:
							selected.modulate = Color(1, 1, 1)
						selected = node
						play_button.visible = true
					
			if _is_sprite_clicked(play_button, mouse_pos):
				print("starting!")
				_send_selected()
		
func _send_selected() -> void:
	print("sending selected")
	emit_signal("path_selected")
	get_tree().change_scene_to_file("res://scenes/alex_map.tscn")
	
					
