extends Node2D

signal test_signal

func _on_area_2d_body_entered(body):
	emit_signal("test_signal")
	print("door_zone " + self.name + " entered by " + body.name)
