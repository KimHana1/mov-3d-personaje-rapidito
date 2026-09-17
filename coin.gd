extends Area3D


signal collected

@export var rotation_speed: float = 2.0 

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _process(delta: float) -> void:
	rotate_y(rotation_speed * delta)

func _on_body_entered(body: Node3D) -> void:
	if body is Player:
		collected.emit()
		GameManager.add_coin()
		queue_free()
