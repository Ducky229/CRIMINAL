class_name HPBar extends Node2D
@onready var tpb: TextureProgressBar = $TextureProgressBar
func _ready() -> void:
	await owner.ready
	if owner is HealthComponent:
		var HC = owner as HealthComponent
		set_max(HC.MaxHealth)

func set_max(value):
	tpb.max_value = value

func update_bar(value):
	tpb.value = value
