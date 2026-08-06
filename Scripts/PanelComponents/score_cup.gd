extends StaticBody2D

@onready var counter_label: Label = $Counter
@export var score_amount := 0

func _on_collect_area_body_entered(body: Node2D) -> void:
	if body.has_signal("ball"):
		Globaldata.set_score_count(score_amount)
		body.queue_free()
