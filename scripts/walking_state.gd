class_name WalkingState extends MovementState

@export var SPEED : float = 250.0
@export var ACCELERATION : float = 1
@export var DECELERATION : float = 5


func update(delta):
	PLAYER.update_attack()
	PLAYER.update_interact()
	PLAYER.update_input(SPEED, ACCELERATION, DECELERATION)
	PLAYER.update_velocity()
	PLAYER.update_rotation()
	
	if PLAYER.velocity.length() == 0.0:
		transition.emit("IdleState")
	if Global.car != null:
		transition.emit("RidingState")
