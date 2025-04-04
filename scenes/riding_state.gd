class_name RidingState extends MovementState
@export var CAR : Car

func enter(previous_state):
	PLAYER.visible = false
	PLAYER.set_collision_layer_value(1, false)
	CAR = Global.car
	CAR.controlled = true

func exit():
	CAR.controlled = false
	PLAYER.visible = true
	PLAYER.set_collision_layer_value(1, true)


func update(delta):
	
	PLAYER.position = CAR.position
	
	CAR.update_car(delta)
	#var vel = CAR.update_input(delta)
	#CAR.update_velocity()
	
	Global.debug.add_property("Velocity", CAR.velocity, 1)
	
	if Input.is_action_just_pressed("interact"):
		PLAYER.global_position = CAR.global_position + Vector2(0, 100)
		Global.car = null
	
	if Global.car == null:
		transition.emit("IdleState")
