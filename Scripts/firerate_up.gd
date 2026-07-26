extends Area2D

@export var text_anim : PackedScene

func _on_body_entered(body: Node2D) -> void:
	create_tag()
	get_tree().current_scene.collected_power(1)
	Globaldata.increase_firerate.emit(0.05)
	Globaldata.firerate -= 0.05
	queue_free()

func create_tag():
	var new_anim = text_anim.instantiate()
	new_anim.global_position = global_position
	var parent : Node2D = get_tree().current_scene
	parent.add_child(new_anim)
