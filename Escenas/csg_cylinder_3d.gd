extends CSGCylinder3D
@export var velocidad: float = 4.0
@export var distancia: float = 4.0

var posicion_inicial: Vector3
var direccion_derecha: Vector3
var tiempo: float = 0.0

func _ready() -> void:
	posicion_inicial = global_position
	direccion_derecha = global_transform.basis.z.normalized() 

func _process(delta: float) -> void:
	tiempo += delta * velocidad
	global_position = posicion_inicial + direccion_derecha * (sin(tiempo) * distancia)
