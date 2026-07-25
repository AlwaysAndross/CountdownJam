extends Area2D

enum GravEnum {UP, DOWN}
@export var gravity_dir : GravEnum
@export var up_color : Color
@export var down_color : Color
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var color_rect: ColorRect = $Sprite2D/ColorRect

func _ready() -> void:
	change_gravity()

func change_gravity():
	if gravity_dir == 0:
		color_rect.color = up_color
	if gravity_dir == 1:
		color_rect.color = down_color
	var collision_shaperect : Rect2 = collision_shape_2d.shape.get_rect()
	sprite_2d.region_rect = Rect2(0,0,collision_shaperect.size.x,collision_shaperect.size.y)
	color_rect.color = up_color
	color_rect.size = Vector2(collision_shaperect.size.x,collision_shaperect.size.y)

func _on_body_entered(body: Node2D) -> void:
	if body.has_signal("ball"):
		if gravity_dir == 0:
			body.change_gravity(1)
		if gravity_dir == 1:
			body.change_gravity(-1)
