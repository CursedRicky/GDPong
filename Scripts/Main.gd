class_name Main extends Node2D

@onready var startLabel: Label = $Control/Start
@onready var animator: AnimationPlayer = $Animator
@onready var label_l: Label = $Control/LabelL
@onready var label_r: Label = $Control/LabelR

var start = true

func _ready() -> void:
	startLabel.visible = true

func _process(delta: float) -> void:
	if start:
		animator.play("LabelOpacityRegulator")
		if Input.is_action_just_pressed("start"):
			animator.stop()
			startLabel.visible = false
			start = false

func _on_score_area_l_body_entered(body: Node2D) -> void:
	label_r.text = str(label_r.text.to_int()+1)
	_on_score("Blue")

func _on_score_area_r_body_entered(body: Node2D) -> void:
	label_l.text = str(label_l.text.to_int()+1)
	_on_score("Red")
	
func _on_score(whoScored: String):
	startLabel.visible = true
	startLabel.text = whoScored + " side Scored"
	$scoreSound.play()
	animator.play("OnScoreAnimation")

func restart():
	Global.restartSignal.emit()
	startLabel.text = "Press start"
	start = true
	$Palla.global_position = Vector2(576, 325)
