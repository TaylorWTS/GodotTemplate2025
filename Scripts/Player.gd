extends CharacterBody2D


const SPEED = 130.0
const JUMP_VELOCITY = -300.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var animated_sprite = $AnimatedSprite2D

func _physics_process(delta):
	# Handle jump.
	if Input.is_action_just_pressed("Move_Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the Input Direction
	var direction = Input.get_axis("Move_Left", "Move_Right")
	
	# Flip The Sprite Direction
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
	
	# Add the gravity and play animations
	if not is_on_floor():
		velocity.y += gravity * delta
		animated_sprite.play("Jump")
	else:
		if direction == 0:
			animated_sprite.play("Idle")
		else:
			animated_sprite.play("Walk")

	# Apply Movement
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
