class_name BasicMovementProcessor extends Node2D

func update_input(speed: float, acceleration: float, deceleration: float, input_dir: Vector2) -> Vector2:
	var direction = input_dir
	if owner is CharacterBody2D:
		if direction:
			owner.velocity.x = lerp(owner.velocity.x, direction.x * speed, acceleration)
			owner.velocity.y = lerp(owner.velocity.y, direction.y * speed, acceleration)
		else:
			owner.velocity.x = move_toward(owner.velocity.x, 0, deceleration)
			owner.velocity.y = move_toward(owner.velocity.y, 0, deceleration)
		return owner.velocity
	else:
		return Vector2.ZERO
func update_velocity():
	if owner is CharacterBody2D:
		owner.move_and_slide()
