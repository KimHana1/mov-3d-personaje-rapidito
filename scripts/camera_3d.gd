extends Camera3D
@export var mouse_sensitivity: float = 0.010
@export var min_pitch_deg: float = -60.0  
@export var max_pitch_deg: float = 45.0    

@onready var player: Node3D = get_parent()  

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)  # oculta y centra el cursor

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		
		player.rotate_y(-event.relative.x * mouse_sensitivity)

		rotation.x -= event.relative.y * mouse_sensitivity
		rotation.x = clamp(rotation.x, deg_to_rad(min_pitch_deg), deg_to_rad(max_pitch_deg))

	if event.is_action_pressed("cancelar"):
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
