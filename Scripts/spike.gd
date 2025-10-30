extends Area2D

#timer delay
@onready var timer = $Timer

#collision detected
func _on_body_entered(_body: Node2D) -> void:
	#start the delay
	timer.start()

#restart the current scene
func _on_timer_timeout():
	get_tree().reload_current_scene()
