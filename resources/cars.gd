class_name Cars extends Resource
@export var NAME : StringName
#@export_category("VisualParameters")
@export var SPRITE : Texture2D
@export var COLOR : Color = Color.WHITE
@export var OCCLUDER_POLYGON : OccluderPolygon2D
#@export_category("PhysicParameters")
@export var WHEEL_BASE : float = 70.0
@export var STEERING_ANGLE : int = 15
@export var ENGINE_POWER = 900
@export var FRICTION = -55
@export var DRAG = -0.06
@export var BRAKING = -450
@export var MAX_SPEED_REVERSE = 250
@export var SLIP_SPEED = 400
@export var TRACTION_FAST = 2.5
@export var TRACTION_SLOW : float = 10
