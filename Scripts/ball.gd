extends RigidBody2D
class_name Ball

signal ball

@export var max_speed: float = 400.0
@export var pop_effect : PackedScene
@onready var bounce_effect: AudioStreamPlayer = $Bounce_Effect
@export var damage : int = 1
var bounced = false
var being_pushed = false
var impulse_force = Vector2(0,0)

func _ready() -> void:
	damage = Globaldata.ball_damage
	Globaldata.increase_damage.connect(increase_damage)
	var rand = randf_range(-1,1)
	var mass_rand = randf_range(1,3)
	mass = mass_rand
	apply_torque(rand)

func _process(delta: float) -> void:
	if being_pushed:
		apply_central_impulse(impulse_force)

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


func _on_area_2d_body_entered(_body: Node2D) -> void:
	if !bounced:
		var randpitch = randf_range(0.7,1.3)
		bounce_effect.pitch_scale = randpitch
		bounce_effect.play()
		bounced = true


func _on_area_2d_body_exited(_body: Node2D) -> void:
	bounce_effect.stop()
	bounced = false

func change_gravity(value):
	gravity_scale = value

func apply_ball_impulse(value):
	impulse_force = value
	being_pushed = true

func remove_ball_impulse():
	impulse_force = Vector2.ZERO
	being_pushed = false

func increase_damage(value):
	damage += value
