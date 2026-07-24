extends Node2D
class_name PachinkoNode

@onready var nine_patch_rect: NinePatchRect = $NinePatchRect
@export var node_animation : PackedScene
@export var activate_position : Vector2i
@export var Pnode_ID : String
@export var default : bool
var initialized : bool = false

func _ready() -> void:
	if !default:
		set_deferred("visible", false)
		global_position = Vector2(-99999,-99999)

#CHECK IF ITS BEEN CREATED AND MOVED
func initialize_pnode():
	if !initialized:
		initialized = true
		global_position = activate_position
		make_new_initial_anim()

#MAKE NEW ANIMATION WHEN NEW PNODE IS CREATED 
func make_new_initial_anim():
	var new_node_animation : NewNodeAnim = node_animation.instantiate()
	new_node_animation.expand_block(nine_patch_rect.size)
	new_node_animation.new_pnode = self
	var parent : Node2D = get_tree().current_scene
	new_node_animation.global_position = activate_position
	parent.add_child(new_node_animation)

func move_node():
	set_deferred("visible",true)
