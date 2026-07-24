extends Control
class_name NumberUI

var hp_value = 2207520000
@onready var human_hp: Label = $HumanHP
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	Globaldata.update_UI_number.connect(update_number)

func update_number(value):
	if value != 0:
		hp_value -= value
		print(hp_value)
		human_hp.text = str(hp_value)
		animation_player.play("update_anim")
