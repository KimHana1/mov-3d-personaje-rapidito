extends Area3D

signal collected

@export var rotation_speed: float = 2.0  # solo estético, para que gire sobre su eje

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _process(delta: float) -> void:
	rotate_y(rotation_speed * delta)

func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		collected.emit()
		GameManager.add_coin()
		queue_free()
