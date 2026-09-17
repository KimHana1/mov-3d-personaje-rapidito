extends Node

signal coin_count_changed(new_count: int)

var coins_collected: int = 0
var total_coins: int = 3

func add_coin() -> void:
	coins_collected += 1
	coin_count_changed.emit(coins_collected)
	print("Monedas: %d / %d" % [coins_collected, total_coins])
	
	if coins_collected >= total_coins:
		print("ATR perri")
