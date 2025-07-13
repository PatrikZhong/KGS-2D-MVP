extends Camera2D

var viewport
# Called when the node enters the scene tree for the first time.
func _ready():
	viewport = get_node("SubViewportContainer")

@export var zoom_factor:float

		
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

func _unhandled_input(event):
	if event.is_action_pressed("zoom_in") and self.zoom.length() < 2:
		# Inside a given class, we need to either write `self._zoom_level = ...` or explicitly
		# call the setter function to use it.
		self.zoom = self.zoom+Vector2(1.0,1.0)*zoom_factor
	if event.is_action_pressed("zoom_out") and self.zoom.length() > 0.4:
		self.zoom = self.zoom+Vector2(1.0,1.0)*zoom_factor*-1
