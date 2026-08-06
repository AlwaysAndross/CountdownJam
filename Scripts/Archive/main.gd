extends Node2D

@onready var zone_destroyed: AudioStreamPlayer = $ZoneDestroyed
@onready var collected_spd: AudioStreamPlayer = $CollectedSPD
@onready var collected_dmg: AudioStreamPlayer = $CollectedDMG
@onready var pachinko_node_a_1: PachinkoModule = $PNodes/pachinko_node_A1
var started : bool = false
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var label: Label = $Label
@onready var animation_player: AnimationPlayer = $AnimationPlayer
var hold_time = 2
@onready var balls_group: Node2D = $Balls
@onready var destory_label: Label = $DestoryLabel
@onready var info: Label = $Info

func _process(delta: float) -> void:
	#if Input.is_action_just_pressed("Exit"):
		#get_tree().quit() 
	if Input.is_action_just_pressed("Shoot"):
		if !started:
			info.set_deferred("visible",true)
			animation_player.stop()
			label.set_deferred("visible", false)
			started = true
			audio_stream_player.play()
			pachinko_node_a_1.initialize_pnode()
	if Input.is_action_pressed("Remove"):
		destory_label.set_deferred("visible", true)
		destory_label.text = "Destroying balls..." + str(snapped(hold_time, 0.01))
		hold_time -= 1 * delta
	if Input.is_action_just_released("Remove"):
		destory_label.set_deferred("visible", false)
		hold_time = 2
	if hold_time <= 0:
		destory_label.set_deferred("visible", false)
		if balls_group.get_child_count() > 0:
			for ball in balls_group.get_children():
				if ball.has_signal("ball"):
					ball.destory()

func destoryed_zone():
	zone_destroyed.play()

func collected_power(value):
	if value == 1:
		collected_spd.play()
	if value == 2:
		collected_dmg.play()
