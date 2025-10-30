extends Area2D


#if the collision detects the player 
func _on_body_entered(_body):
	#display coin collected in Output
	print("+ 1 Coin")
	#Delete this coin
	queue_free()
