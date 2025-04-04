class_name Player extends CharacterBody2D
@onready var interact_ray: RayCast2D = $InteractRay
@export var debug_cursor : bool = true
@export var WEAPONS : Array[Weapons]
const BULLET = preload("res://scenes/bullet.tscn")

@export var bullet_ricochets : int = 1
@onready var bmp: Node2D = $BasicMovementProcessor
@onready var WEAPON: WeaponController = $Weapon


@export var BulletLifetime : float = 3.0
func _ready():
	WEAPON.set_weapon(WEAPONS.back())
	Global.player = self

func update_attack():
	if Input.is_action_just_pressed("attack"):
		WEAPON.attack()

func update_interact():
	
	
	
	if Input.is_action_just_pressed("interact"):
		var object = interact_ray.get_collider()
		if object:
			if object.has_method("interact"):
				object.interact()
			if object is Car:
				Global.car = object as Car

func update_rotation():
	#print(transform.x)
	if global_position.distance_to(get_global_mouse_position()) > 20:
		look_at(get_global_mouse_position())

func update_input(speed: float, acceleration: float, deceleration: float) -> Vector2:
	var input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	return bmp.update_input(speed, acceleration, deceleration, input_dir)

func update_velocity():
	move_and_slide()
