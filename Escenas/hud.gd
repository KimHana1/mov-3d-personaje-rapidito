extends CanvasLayer

@onready var coin_label: Label = $CoinLabel

func _ready() -> void:
	update_coin_text(GameManager.coins_collected) 
	GameManager.coin_count_changed.connect(update_coin_text)

func update_coin_text(amount: int) -> void:
	coin_label.text = "Monedas: " + str(amount) + " / " + str(GameManager.total_coins)
