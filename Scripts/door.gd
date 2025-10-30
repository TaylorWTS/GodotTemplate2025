extends Area2D

#Timer used for delay
@onready var timer: Timer = $Timer
#animation to play for opening the door
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

#Collision detected 
func _on_body_entered(_body: Node2D) -> void:
		#start timer for delay
		timer.start()
		#play the open door animation
		animated_sprite_2d.play("open")
		
#Delay finished playing
func _on_timer_timeout():
	#find the location of the current scene
	var current_Scene_File = get_tree().current_scene.scene_file_path
	#find the next scene by converting to number and adding 1
	var next_level_number = current_Scene_File.to_int() + 1
	#return the value to a string and use it to swap the currently loaded scene
	var _next_level_Path = "res://Levels/level_" + str(next_level_number) + ".tscn"
	get_tree().change_scene_to_file(_next_level_Path)
