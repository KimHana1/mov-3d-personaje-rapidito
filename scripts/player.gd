extends CharacterBody3D
class_name Player

@export var speed: float = 7.0            
@export var acceleration: float = 20.0    
@export var deceleration: float = 25.0    
@export var air_control: float = 0.7      
@export var rotation_speed: float = 12.0  

@export var jump_velocity: float = 6.5        
@export var double_jump_velocity: float = 5.5 
@export var gravity_scale: float = 2.0        

@export var fall_death_y: float = -10.0       # si la Y del jugador baja de esto, muere
@export var respawn_point: NodePath           # arrastrá acá un Marker3D (opcional)

var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")

var jumps_left: int = 2
var _input_dir: Vector3 = Vector3.ZERO

@onready var visual: Node3D = $Visual   


func _physics_process(delta: float) -> void:
	_handle_gravity(delta)
	_handle_jump()
	_handle_movement(delta)
	_orient_visual(delta)

	move_and_slide()

	if is_on_floor():
		jumps_left = 2

	_check_fall_death()


func _handle_gravity(delta: float) -> void:
	if not is_on_floor():
		velocity.y -= gravity * gravity_scale * delta


func _handle_jump() -> void:
	if Input.is_action_just_pressed("saltito") and jumps_left > 0:
		if jumps_left == 2:
			velocity.y = jump_velocity
		else:
			velocity.y = double_jump_velocity
		jumps_left -= 1


func _handle_movement(delta: float) -> void:
	var input_vector := Vector2(
		Input.get_action_strength("derechita") - Input.get_action_strength("izquierdita"),
		Input.get_action_strength("atras") - Input.get_action_strength("delantito")
	)
	input_vector = input_vector.normalized() if input_vector.length() > 1.0 else input_vector

	var cam := get_viewport().get_camera_3d()
	var forward := Vector3.FORWARD
	var right := Vector3.RIGHT
	if cam:
		forward = -cam.global_transform.basis.z
		right = cam.global_transform.basis.x
		forward.y = 0
		right.y = 0
		forward = forward.normalized()
		right = right.normalized()

	_input_dir = (right * input_vector.x + forward * -input_vector.y)
	_input_dir = _input_dir.normalized() if _input_dir.length() > 1.0 else _input_dir

	var target_velocity := _input_dir * speed
	var accel := acceleration if is_on_floor() else acceleration * air_control
	var decel := deceleration if is_on_floor() else deceleration * air_control

	var horizontal := Vector3(velocity.x, 0.0, velocity.z)

	if _input_dir.length() > 0.01:
		horizontal = horizontal.move_toward(target_velocity, accel * get_physics_process_delta_time())
	else:
		horizontal = horizontal.move_toward(Vector3.ZERO, decel * get_physics_process_delta_time())

	velocity.x = horizontal.x
	velocity.z = horizontal.z


func _orient_visual(delta: float) -> void:
	if _input_dir.length() > 0.1:
		var target_angle := atan2(_input_dir.x, _input_dir.z)
		visual.rotation.y = lerp_angle(visual.rotation.y, target_angle, rotation_speed * delta)


func _check_fall_death() -> void:
	if global_position.y < fall_death_y:
		die()


func die() -> void:
	if respawn_point != NodePath("") and has_node(respawn_point):
		var spawn: Node3D = get_node(respawn_point)
		velocity = Vector3.ZERO
		global_position = spawn.global_position
	else:
		get_tree().reload_current_scene()
