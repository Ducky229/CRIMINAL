class_name HealthComponent extends Node
@export var MaxHealth : float = 100.0

signal health_changed(value)
signal death


@export var Health : float = MaxHealth:
	set(value):
		Health = value
		if Health <= 0:
			death.emit()
		health_changed.emit(Health)
