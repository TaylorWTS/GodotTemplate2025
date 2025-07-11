extends Area2D
@onready var timer: Timer = $Timer
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


func _on_body_entered(_body: Node2D) -> void:
		timer.start()
		animated_sprite_2d.play("open")
		$Open.play()
func _on_timer_timeout():
	var current_Scene_File = get_tree().current_scene.scene_file_path
	var next_level_number = current_Scene_File.to_int() + 1
	var _next_level_Path = "res://Levels/level_" + str(next_level_number) + ".tscn"
	get_tree().change_scene_to_file(_next_level_Path)


func _on_open_finished() -> void:
	pass # Replace with function body.
