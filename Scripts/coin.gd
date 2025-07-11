extends Area2D



func _on_body_entered(_body):
	$Collect.play()
	print("+ 1 Coin")
	$AnimatedSprite2D.hide()


func _on_collect_finished() -> void:
	queue_free()
