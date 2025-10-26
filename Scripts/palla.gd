class_name Palla extends CharacterBody2D

const XSPEED = 600
const YSPEED = 4

var xSpeed = XSPEED
var ySpeed = YSPEED
var multiplier = 10
var start = true
var paused = false

var possibleMultiplier = [1, -1]

func _ready() -> void:
	Global.restartSignal.connect(restart)

func restart():
	paused = true

func _physics_process(delta):
	
	if not paused:
		if not start:
			velocity = Vector2(xSpeed, ySpeed*multiplier)
		else :
			if Input.is_action_just_pressed("start"):
				xSpeed = xSpeed*possibleMultiplier[randi_range(0,1)]
				start = false
		var collision = move_and_collide(velocity*delta)
		if collision:
			$AudioStreamPlayer2D.pitch_scale = randf_range(.9, 1.2)
			$AudioStreamPlayer2D.play()
			if (collision.get_collider().is_class("CharacterBody2D")):
				xSpeed = -xSpeed
				if xSpeed < 0:
					xSpeed -= 10
				else :
					xSpeed += 10
				ySpeed = randi_range(8,20)
			else :
				multiplier = -multiplier
	else :
		if Input.is_action_just_pressed("start"):
			xSpeed = XSPEED
			ySpeed = YSPEED
			paused = false
