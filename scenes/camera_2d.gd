extends Camera2D

var viewport
# Called when the node enters the scene tree for the first time.
func _ready():
	viewport = get_node("SubViewportContainer")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#self.global_position = viewport.mouse_pos
	var mpos = get_viewport().get_mouse_position() - get_viewport_rect().size/2
	var cpos = self.get_screen_center_position()
	print(mpos)
	print(cpos)
	print("")
	if mpos.abs().x > get_viewport_rect().size.x/2*0.8 or mpos.abs().y > get_viewport_rect().size.y/2*0.8:
		self.global_position = self.global_position + mpos*0.01
