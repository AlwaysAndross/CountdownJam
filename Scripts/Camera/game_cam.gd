extends Camera2D

var is_dragging := false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ZoomIn"):
		if zoom.x < 2:
			zoom += Vector2(0.1,0.1)
	if Input.is_action_just_pressed("ZoomOut"):
		if zoom.x > 0.5:
			zoom += Vector2(-0.1,-0.1)
	
	if event is InputEventMouseMotion and is_dragging:
		global_position -= event.relative
	
	if Input.is_action_just_pressed("influence"):
		is_dragging = true
	if Input.is_action_just_released("influence"):
		is_dragging = false
