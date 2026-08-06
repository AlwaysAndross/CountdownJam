extends CanvasLayer

@onready var score_count_label: Label = $BallCount/BallCount_Label


func _ready():
	Globaldata.update_score_count.connect(update_number)

func update_number(value):
	score_count_label.text = str(Globaldata.get_score_count())
