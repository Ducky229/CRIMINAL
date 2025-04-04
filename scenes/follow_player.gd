@tool
class_name FollowPlayer extends Node2D
@export var FOLLOW : Node2D
@export var OWNER : Node2D
@export var KEEP_POSITION : bool = true
@export var KEEP_ROTATION : bool = false
@export var KEEP_SCALE : bool = false

func _process(delta: float) -> void:
	if !OWNER or !FOLLOW:
		return
	
	if KEEP_POSITION:
		OWNER.global_position = FOLLOW.global_position
	if KEEP_ROTATION:
		OWNER.global_rotation = FOLLOW.global_rotation
	if KEEP_SCALE:
		OWNER.global_scale = FOLLOW.global_scale
	#print(OWNER.position)
	#print("correction")
