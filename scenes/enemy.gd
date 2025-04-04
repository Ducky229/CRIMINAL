class_name Enemy extends CharacterBody2D
var previous_rotation
@onready var HC: HealthComponent = $HealthComponent
@onready var BMP: BasicMovementProcessor = $BasicMovementProcessor
@export var DIRECTION : Vector2 = Vector2.RIGHT
@onready var WEAPON: WeaponController = $Weapon
@export var USED_WEAPON : Weapons

func _ready() -> void:
	WEAPON.set_weapon(USED_WEAPON)

func hit(dmg):
	HC.Health -= dmg

var attack_timer = 0.5
var roam_timer = 3.0

func update_roam(delta):
	roam_timer -= delta
	if roam_timer <= 0:
		DIRECTION = DIRECTION.rotated(deg_to_rad(90))
		roam_timer = 3.0

func see_target(target, location) -> bool:
	var AP = global_position.direction_to(location)
	if AP.dot(transform.x) > 0:
		#print("ENEMY SEES PLAYERA!")
		var player = find_for(location)
		if player is Player:
			return true
	return false

func find_for(object : Vector2):
	var space_state = get_world_2d().direct_space_state
	var query = PhysicsRayQueryParameters2D.create(global_position, object)
	var result = space_state.intersect_ray(query)
	if result:
		var collider = result.collider
		print("Hit", result.collider)
		return collider

func update_attack(delta):
	
	attack_timer -= delta
	if attack_timer <= 0:
		WEAPON.attack()
		attack_timer = 0.5

func update_input(speed: float, acceleration: float, deceleration: float):
	BMP.update_input(speed, acceleration, deceleration, DIRECTION)
	rotation = DIRECTION.angle()

func update_velocity():
	BMP.update_velocity()
