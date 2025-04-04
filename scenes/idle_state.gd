class_name IdleState extends MovementState

@export var SPEED : float = 250.0
@export var ACCELERATION : float = 1
@export var DECELERATION : float = 1


func update(delta):
	PLAYER.update_interact()
	PLAYER.update_attack()
	var vel = PLAYER.update_input(SPEED, ACCELERATION, DECELERATION)
	PLAYER.update_velocity()
	PLAYER.update_rotation()
	
	if PLAYER.velocity.length() > 0.0:
		transition.emit("WalkingState")
	if Global.car != null:
		transition.emit("RidingState")
