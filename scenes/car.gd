class_name Car extends CharacterBody2D

@export var parameters : Cars


@onready var sprite: Sprite2D = $Sprite
@onready var light_occluder_2d: LightOccluder2D = $LightOccluder2D

var steer_direction
var acceleration = Vector2.ZERO
var controlled : bool = false
func get_input():
	
	var turn = Input.get_axis("move_left", "move_right")
	steer_direction = turn * deg_to_rad(parameters.STEERING_ANGLE)
	if Input.is_action_pressed("move_up"):
		acceleration = transform.x * parameters.ENGINE_POWER
	if Input.is_action_pressed("move_down"):
		acceleration = transform.x * parameters.BRAKING
		#print("DOWN")
func calculate_steering(delta):
	var rear_wheel = position - transform.x * parameters.WHEEL_BASE / 2.0
	var front_wheel = position + transform.x * parameters.WHEEL_BASE / 2.0
	
	rear_wheel += velocity * delta
	front_wheel += velocity.rotated(steer_direction) * delta
	var new_heading = (front_wheel - rear_wheel).normalized()
	var traction = parameters.TRACTION_SLOW
	if velocity.length() > parameters.SLIP_SPEED:
		traction = parameters.TRACTION_FAST
	var d = new_heading.dot(velocity.normalized())
	#Global.debug.add_property("D", d, 2)
	#Global.debug.add_property("Acceleration", acceleration, 3)
	if d > 0:
		velocity = lerp(velocity, new_heading * velocity.length(), traction * delta)
	if d < 0:
		velocity = -new_heading * min(velocity.length(), parameters.MAX_SPEED_REVERSE)
	#print(acceleration) ######################
	#var new_heading = rear_wheel.direction_to(front_wheel)
	
	#velocity = new_heading * velocity.length()
	rotation = new_heading.angle()

func apply_friction(delta):
	if acceleration == Vector2.ZERO and velocity.length() < 50:
		velocity = Vector2.ZERO
	var friction_force = velocity * parameters.FRICTION * delta
	var drag_force = velocity * velocity.length() * parameters.DRAG * delta
	acceleration += drag_force + friction_force

var collided : bool

func _ready() -> void:
	sprite.texture = parameters.SPRITE
	sprite.modulate = parameters.COLOR
	light_occluder_2d.occluder = parameters.OCCLUDER_POLYGON

func interact():
	Global.car = self

func update_car(delta) -> void:
	acceleration = Vector2.ZERO
	
	get_input()
	calculate_steering(delta)
	velocity += acceleration * delta
	collided = move_and_slide()
	#if collided:
		#velocity = velocity / 3.0
		
		#var collider = get_slide_collision(0).get_collider()
		#if collider is Car:
			#print(collider)
			#collider.velocity = velocity / 2.0
			

func update_input(delta) -> Vector2:
	#var input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	return velocity
	#var direction = transform.x * -input_dir.y
	
	#rotation += input_dir.x * delta * velocity.length() / 100
	
	#if direction:
		
		#rotate(direction.x)
		#velocity.x = lerp(velocity.x, direction.x * parameters.SPEED, parameters.ACCELERATION)
		#velocity.y = lerp(velocity.y, direction.y * parameters.SPEED, parameters.ACCELERATION)
	#else:
		#velocity.x = move_toward(velocity.x, 0, parameters.DECELERATION)
		#velocity.y = move_toward(velocity.y, 0, parameters.DECELERATION)
	#return velocity

func _physics_process(delta: float) -> void:
	if !controlled:
		velocity.x = move_toward(velocity.x, 0.0, delta)
		velocity.y = move_toward(velocity.y, 0.0, delta)
		collided = move_and_slide()
		if collided:
			
			var collider = get_slide_collision(0).get_collider()
			if collider is Car:
			
				var car = collider as Car
				if velocity < car.velocity:
					velocity = car.velocity / 2.0
					car.velocity = car.velocity / 3.0
				else:
					car.velocity = velocity / 2.0
					velocity = velocity / 3.0
				
			#if velocity < collided.velocity:
				#velocity = collided.velocity / 2.0
				
	
