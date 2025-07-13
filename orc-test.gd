extends base_monster

func _ready():
	sprite = $OrcSprite  # Set the specific sprite reference
	super._ready()  


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
