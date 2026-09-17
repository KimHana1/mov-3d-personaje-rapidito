extends Area3D


signal collected

@export var rotation_speed: float = 2.0 

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _process(delta: float) -> void:
	rotate_y(rotation_speed * delta)

func _on_body_entered(body: Node3D) -> void:
	print("¡Algo entró al área!: ", body.name) # Línea de prueba 1
	if body.is_in_group("player"):
		print("¡Es el jugador confirmado!")      # Línea de prueba 2
		collected.emit()
		GameManager.add_coin()
		queue_free()
