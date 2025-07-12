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
	if timer.is_stopped():
		timer.start()
		current_map.queue_free()
		emit_signal("redrawing_map")
		emit_signal("timeout")
		current_map=spawn_new_map()
	
		
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
	
	
