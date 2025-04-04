class_name EnemyGoingForPlayer extends EnemyState

var change_timer : Timer

func enter(previous_state):
	change_timer = Timer.new()
	change_timer.wait_time = 5
	add_child(change_timer)
	change_timer.timeout.connect(func(): transition.emit("EnemyIdleState"))

func update(delta):
	ENEMY.look_at(Global.player.position)
	ENEMY.update_attack(delta)
	
	
	if ENEMY.position.distance_to(Global.player.position) >= 500:
		if change_timer.is_stopped():
			change_timer.start()
	elif !ENEMY.see_target(Global.player, Global.player.global_position):
		if change_timer.is_stopped():
			change_timer.start()
	else:
		change_timer.stop()

func exit():
	ENEMY.rotation = ENEMY.previous_rotation
