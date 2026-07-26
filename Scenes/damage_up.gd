extends Area2D


func _on_body_entered(body: Node2D) -> void:
	Globaldata.increase_damage.emit(1)
	Globaldata.ball_damage += 1
	queue_free()
