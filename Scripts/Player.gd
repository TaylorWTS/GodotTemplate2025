extends CharacterBody2D

#player speed
const SPEED = 130.0
#player jump strength
const JUMP_VELOCITY = -300.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

#player animations
@onready var animated_sprite = $AnimatedSprite2D

#'coyote_time' is designed to allow the player to jump after they leave the ground, this is important for jumping on slopped surfaces and makes platforming much easier.
@onready var CoyoteClock = $Timer
#the latch is there to make sure the coyote_time doesn't trigger more than once, this would create an accidental double jump
var CoyoteLatch: bool = false

#physics update
func _physics_process(delta):
	# Get the Input Direction
	var direction = Input.get_axis("Move_Left", "Move_Right")
	
	# Flip The Sprite Direction
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
	
	# Add the gravity and play animations
	if not is_on_floor():
		if CoyoteClock.is_stopped():
			CoyoteClock.start()
		velocity.y += gravity * delta
		animated_sprite.play("Jump")
	else:
		CoyoteLatch = false
		if direction == 0:
			animated_sprite.play("Idle")
		else:
			animated_sprite.play("Walk")
	# Handle jump.
	if Input.is_action_just_pressed("Move_Jump") and (is_on_floor() or !CoyoteClock.is_stopped()):
		if CoyoteLatch == false:
			CoyoteLatch = true
			velocity.y = JUMP_VELOCITY
	# Apply Movement
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
