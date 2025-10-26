class_name Player extends CharacterBody2D

const SPEED = 600.0

func _physics_process(delta):
	velocity.y = 0
	velocity.x = 0
	var direction = Input.get_axis("ui_up", "ui_down")
	if direction:
		velocity.y = direction * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)

	var collision = move_and_collide(velocity*delta)
