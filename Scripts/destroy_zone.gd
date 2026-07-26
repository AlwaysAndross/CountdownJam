extends Area2D

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var color_rect: ColorRect = $Sprite2D/ColorRect
@onready var area_hp_label: Label = $area_HP

@export var is_infinite : bool
@export var new_zone : String
@export var has_new_zone : bool
@export var grid_color : Color 
@export var area_start_hp : int = 9
@export var destroy_blocks : Array[TileMapLayer] 
var current_HP = 1

func _ready() -> void:
	initialize_HP()
	var collision_shaperect : Rect2 = collision_shape_2d.shape.get_rect()
	sprite_2d.region_rect = Rect2(0,0,collision_shaperect.size.x,collision_shaperect.size.y)
	color_rect.color = grid_color
	color_rect.size = Vector2(collision_shaperect.size.x,collision_shaperect.size.y)
	area_hp_label.global_position = \
	Vector2(global_position.x + (collision_shaperect.size.x/2) - 55,global_position.y + (collision_shaperect.size.y/2) -14)

func _on_body_entered(body: Node2D) -> void:
	if body.has_signal("ball"):
		body.destory()
		if !is_infinite:
			update_HP(body.damage)

func update_HP(value):
	current_HP -= value
	if current_HP <= 0:
		destory_zone()
	area_hp_label.text = str(current_HP)

func initialize_HP():
	if !is_infinite:
		current_HP = area_start_hp
		area_hp_label.text = str(area_start_hp)
	else:
		area_hp_label.set_deferred("visible", false)

func destory_zone():
	get_tree().current_scene.destoryed_zone()
	if destroy_blocks.size() > 0:
		for layers in destroy_blocks:
			layers.queue_free()
	if has_new_zone:
		var PnodeArray  = get_tree().current_scene.find_child("PNodes").get_children()
		for Pnode in PnodeArray:
			var Pnodename_match = "pachinko_node_" + str(new_zone)
			var Pnodename_current = "pachinko_node_" + str(Pnode.Pnode_ID)
			if Pnodename_match == Pnodename_current:
				Pnode.initialize_pnode()
	queue_free()
