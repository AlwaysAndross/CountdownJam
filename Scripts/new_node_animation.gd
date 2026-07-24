extends Node2D
class_name NewNodeAnim

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var nine_patch_rect: NinePatchRect = $NinePatchRect
var new_size : Vector2
var start_resize = false
var play = false
var new_pnode 

func _ready() -> void:
	nine_patch_rect.size = Vector2(10,13)

func expand_block(value):
	new_size = value
	start_resize = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if start_resize:
		nine_patch_rect.size.x = lerpf(nine_patch_rect.size.x, new_size.x, 0.07)
		nine_patch_rect.size.y = lerpf(nine_patch_rect.size.y, new_size.y, 0.07)
		if nine_patch_rect.size.x >= new_size.x - 1:
			if !play:
				play = true
				animation_player.play("finish_pnode")

func make_visible():
	new_pnode.move_node()

func destoryself():
	queue_free()
