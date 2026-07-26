extends Node2D

func _ready() -> void:
	global_position = Vector2(-2222222,-1111111)
func _process(delta: float) -> void:
	if Input.is_action_pressed("influence"):
		global_position = get_global_mouse_position()
	if Input.is_action_just_released("influence"):
		global_position = Vector2(-2222222,-1111111)
