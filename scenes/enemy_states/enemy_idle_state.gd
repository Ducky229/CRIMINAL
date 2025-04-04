class_name EnemyIdleState extends EnemyState

@export var SPEED : float = 50.0
@export var ACCELERATION : float = 1
@export var DECELERATION : float = 5

func update(delta):
	ENEMY.update_roam(delta)
	ENEMY.update_input(SPEED, ACCELERATION, DECELERATION)
	ENEMY.update_velocity()
	if ENEMY.position.distance_to(Global.player.position) < 500:
		if ENEMY.see_target(Global.player, Global.player.global_position):
			ENEMY.previous_rotation = ENEMY.rotation
			transition.emit("EnemyGoingForPlayer")
	
	ENEMY.update_velocity()
