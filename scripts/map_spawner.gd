extends Node2D



signal redrawing_map
signal timeout
@export var map_blocks: Array[PackedScene]

var current_map
var timer
var last_rand

func _on_timeout():
	timer.stop()

func _on_zone_testsignal():
	Globals.done_collumns.append(Globals.done_collumns[-1] + 1)

	get_tree().change_scene_to_file("res://scenes/rasmus_playground.tscn")
	
		
func spawn_new_map():
	var new_rand = last_rand
	while new_rand == last_rand:
		new_rand = randi_range(0, map_blocks.size()-1)
	last_rand = new_rand
	var mb = map_blocks[new_rand].instantiate()
		
	self.add_child(mb)
	print("spawned map " + mb.name)
	
	var door_zones = mb.get_child(0).get_children()
	
	for door_zone in door_zones:
		door_zone.test_signal.connect(Callable(self, "_on_zone_testsignal"))
		
	return mb
	
# Called when the node enters the scene tree for the first time.
func _ready():
	current_map = spawn_new_map()
	timer = Timer.new()
	add_child(timer)
	timer.wait_time = 1.0
	self.timer.timeout.connect(Callable(self, "_on_timeout"))
	
	var spawnpoints = get_tree().get_nodes_in_group("spawnpoints")
	print(spawnpoints)
	if spawnpoints != []:
		var characters = get_tree().get_nodes_in_group("Players")
		print(characters)
		for i in range(characters.size()):
			characters[i].global_position = spawnpoints[i].global_position
		
	
