extends CharacterBody2D

const Speed = 30
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var OnFloor = true
var Direction = 1
@onready var ray_cast_2d_right: RayCast2D = $RayCast2DRight
@onready var ray_cast_2d_left: RayCast2D = $RayCast2DLeft
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
func _physics_process(delta):
	if not is_on_floor():
		OnFloor = false
		velocity.y += gravity * delta
	else:
		OnFloor = true
	move_and_slide()
func _process(delta: float) -> void:
	if OnFloor:
		position.x += Direction * Speed * delta
		if ray_cast_2d_right.is_colliding():
			Direction = -1
			animated_sprite.flip_h = true
		if ray_cast_2d_left.is_colliding():
			Direction = 1
			animated_sprite.flip_h = false
	
