extends RigidBody2D
class_name Ball

signal ball

@export var max_speed: float = 1000.0
@export var pop_effect : PackedScene
@onready var bounce_effect: AudioStreamPlayer = $Bounce_Effect
@export var damage : int = 1
var bounced = false
var being_pushed = false
var impulse_force = Vector2(0,0)
var effect_group = null

func _ready() -> void:
	damage = Globaldata.ball_damage
	Globaldata.increase_damage.connect(increase_damage)

func _process(_delta: float) -> void:
	if being_pushed:
		apply_central_impulse(impulse_force)

func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	var current_velocity = state.linear_velocity
	var current_speed = current_velocity.length()
	if current_speed > max_speed:
		state.linear_velocity = current_velocity.normalized() * max_speed

func shoot_ball(target_angle):
	var rand_force = randi_range(1000,2000)
	apply_central_force(target_angle * rand_force)

func destory():
	var new_effect  = pop_effect.instantiate()
	new_effect.global_position = global_position
	effect_group.add_child(new_effect)
	queue_free()


func _on_area_2d_body_entered(_body: Node2D) -> void:
	if !bounced:
		var randpitch = randf_range(1.3,1.8)
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
