class_name Bullet extends CharacterBody2D
@export var bullet_speed : float = 500
@export var ricochet : int = 0
@export var bullet_dmg : float = 20.0
func start(_position, _direction):
	rotation = _direction
	position = _position
	velocity = Vector2(bullet_speed, 0).rotated(rotation)

func _physics_process(delta: float) -> void:
	var collision = move_and_collide(velocity * delta)
	if collision:
		if collision.get_collider().has_method("hit"):
			
			collision.get_collider().hit(bullet_dmg)
			queue_free()
		
		if ricochet > 0:
			var angle = rad_to_deg(velocity.normalized().angle_to(collision.get_normal()))
			if abs(angle) < 120:
				print(angle)
				velocity = velocity.bounce(collision.get_normal())
				#print(velocity.bounce(collision.get_normal()))
				ricochet -= 1
			else:
				queue_free()
		else:
			queue_free()
