extends RigidBody2D
class_name Ball

signal ball

@export var max_speed: float = 400.0
@export var pop_effect : PackedScene
@onready var bounce_effect: AudioStreamPlayer = $Bounce_Effect

func _ready() -> void:
	bounce_effect.play()
	var rand = randf_range(-1,1)
	var mass_rand = randf_range(1,3)
	mass = mass_rand
	apply_torque(rand)

func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	var current_velocity = state.linear_velocity
	var current_speed = current_velocity.length()
	if current_speed > max_speed:
		state.linear_velocity = current_velocity.normalized() * max_speed

func shoot_ball(target_angle):
	apply_central_force(target_angle * 1500)

func destory():
	var new_effect  = pop_effect.instantiate()
	new_effect.global_position = global_position
	var parent : Node2D = get_tree().current_scene.find_child("Balls")
	parent.add_child(new_effect)
	queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	destory()
