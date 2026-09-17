extends Area3D

@export var respawn_point: NodePath   

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		_kill_player(body)

func _kill_player(player: Node3D) -> void:
	if respawn_point != NodePath("") and has_node(respawn_point):
		var spawn: Node3D = get_node(respawn_point)
		player.velocity = Vector3.ZERO
		player.global_position = spawn.global_position
	else:
		
		get_tree().reload_current_scene()
