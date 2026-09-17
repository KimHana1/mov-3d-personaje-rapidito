extends CSGCylinder3D
@export var velocidad: float =2.0
@export var distancia: float = 3.5

var posicion_inicial: Vector3
var tiempo: float = 0.0

func _ready() -> void:
	posicion_inicial = global_position

func _process(delta: float) -> void:
	tiempo += delta * velocidad
	global_position.z = posicion_inicial.z + (sin(tiempo) * distancia)
