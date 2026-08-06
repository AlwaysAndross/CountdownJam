extends Area2D

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var color_rect: ColorRect = $Sprite2D/ColorRect
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@export var impulse_force : Vector2 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var collision_shaperect : Rect2 = collision_shape_2d.shape.get_rect()
	sprite_2d.region_rect = Rect2(0,0,collision_shaperect.size.x,collision_shaperect.size.y)
	color_rect.size = Vector2(collision_shaperect.size.x,collision_shaperect.size.y)

func _on_body_entered(body: Node2D) -> void:
	if body.has_signal("ball"):
		body.apply_ball_impulse(impulse_force)

func _on_body_exited(body: Node2D) -> void:
	if body.has_signal("ball"):
		body.remove_ball_impulse()
