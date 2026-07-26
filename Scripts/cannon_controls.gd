extends Node2D

var target_angle
var calculate_mouse_pos = true
var rotation_speed = 10

@onready var roation_group: Node2D = $RoationGroup
@onready var ball_marker: Marker2D = $RoationGroup/BallMarker

@export var ball : PackedScene
@export var shot_delay : float = 0.8
var shot_delay_time : float = 0

func _ready() -> void:
	Globaldata.increase_firerate.connect(increase_firerate)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if calculate_mouse_pos:
		target_angle = get_angle_to(get_global_mouse_position()) - 1.6
	
	if target_angle > 1.5 or target_angle < -3:
		target_angle = 1.5
	if target_angle < -1.5 and target_angle > -3:
		target_angle = -1.5
	
	if roation_group.rotation != target_angle:
		var rotation_lerp_weight: float = 1.0 - exp(-rotation_speed * delta)
		roation_group.rotation = lerp_angle(roation_group.rotation, target_angle, rotation_lerp_weight)
	if Input.is_action_pressed("Shoot"):
		if shot_delay_time <= 0:
			shot_delay_time = shot_delay
			make_ball(target_angle)
	if shot_delay_time > 0:
		shot_delay_time -= 1 * delta

func make_ball(target_angle):
	var shoot_angle = ball_marker.global_position - roation_group.global_position
	#create ball instance
	var new_ball : Ball  = ball.instantiate()
	new_ball.global_position = ball_marker.global_position
	var parent : Node2D = get_tree().current_scene.find_child("Balls")
	new_ball.shoot_ball(shoot_angle)
	parent.add_child(new_ball)

func increase_firerate(value):
	shot_delay -= value
