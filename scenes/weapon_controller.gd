class_name WeaponController extends Node2D
@onready var gun_point: Marker2D = %Marker2D

var ACTIVE_WEAPON : Weapons

func set_weapon(weapon : Weapons):
	ACTIVE_WEAPON = weapon

func attack():
	var b = ACTIVE_WEAPON.BULLET.instantiate()
	b.ricochet = 1
	b.start(gun_point.global_position, owner.rotation)
	get_tree().root.add_child(b)
	await get_tree().create_timer(ACTIVE_WEAPON.BULLETLIFETIME).timeout
	if b:
		b.queue_free()
