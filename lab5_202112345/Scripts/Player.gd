extends CharacterBody2D

# Constants
const SPEED = 200          # Speed for horizontal movement
const JUMP_FORCE = -600    # Jump force (negative because Y-axis goes down)
const GRAVITY = 900        # Gravity applied when the player is in the air

# Variables for player's health and points
var health = 100
var points = 0

# Variables to handle vertical velocity
var vertical_velocity = 0.0  # Vertical speed (gravity, jumping, falling)

func _process(delta):
	handle_movement(delta)
	handle_gravity_and_jump(delta)

# Function to handle player movement (horizontal)
func handle_movement(delta):
	var direction = Vector2.ZERO
	
	# Left and Right Movement
	if Input.is_action_pressed("ui_right"):
		direction.x += 1
	if Input.is_action_pressed("ui_left"):
		direction.x -= 1
	
	# Set the horizontal movement velocity
	velocity.x = direction.x * SPEED

# Function to handle jumping, gravity, and falling
func handle_gravity_and_jump(delta):
	# Check if the player is on the floor using the `is_on_floor` property
	if is_on_floor():
		# If the player is on the floor and presses the jump button
		if Input.is_action_just_pressed("ui_accept"):  # ui_accept mapped to Spacebar
			vertical_velocity = JUMP_FORCE  # Apply upward force for jumping
		else:
			vertical_velocity = 0  # Reset vertical velocity to 0 if grounded and not jumping
	else:
		# If the player is in the air, apply gravity
		vertical_velocity += GRAVITY * delta

	# Apply vertical movement to the velocity
	velocity.y = vertical_velocity
	
	# Move the player using the velocity vector (horizontal + vertical)
	move_and_slide()  # Just call move_and_slide() without arguments
