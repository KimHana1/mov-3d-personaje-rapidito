extends Area3D


var _finalizado: bool = false 

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node3D) -> void:
	if _finalizado:
		return
	if body.is_in_group("player"):
		_finalizado = true
		_evaluar_final()

func _evaluar_final() -> void:
	if GameManager.coins_collected >= GameManager.total_coins:
		UImanager.show_message("¡CRACK, MASTER, ÍDOLO, MÁQUINA,\nFIERA MASTODONTE COMPLETO,\nCAPO, ARTISTA!")
	else:
		UImanager.show_message("Ganaste.")
