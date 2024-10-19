extends Area2D

var timer: Timer
var hurtTimer: Timer
var sprite: AnimatedSprite2D

# Variables for movement
var speed: float = 100.0  # Speed of the goblin
var move_direction: Vector2 = Vector2(1, 0)  # Start moving left
var left_limit = -50  # Left boundary relative to the start position
var right_limit = 50  # Right boundary relative to the start position
var start_position: Vector2  # To store the goblin's starting position

func _ready():
	# Initialize the timers and the sprite
	hurtTimer = get_node("HurtTimer")
	timer = get_node("Timer")
	sprite = get_node("AnimatedSprite2D")
	
	# Store the initial position of the goblin
	start_position = position

func _process(delta):
	move_goblin(delta)

func move_goblin(delta):
	# Move the goblin based on the current direction
	position += move_direction * speed * delta

	# Check if the goblin has reached the left or right limit
	if position.x <= start_position.x + left_limit:
		# Reached the left limit, so flip direction to right
		move_direction.x = 1
		flip_sprite()
	elif position.x >= start_position.x + right_limit:
		# Reached the right limit, so flip direction to left
		move_direction.x = -1
		flip_sprite()

# Function to flip the goblin sprite based on the direction
func flip_sprite():
	if move_direction.x == 1:
		# Face right by setting positive scale.x
		sprite.scale.x = abs(sprite.scale.x)
	else:
		# Face left by setting negative scale.x
		sprite.scale.x = -abs(sprite.scale.x)

# Handle damage when the player enters the goblin's area
func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player" and Global.health <= 100 and Global.health > 0:
		Global.health -= 10
		Global.getHurt = true
		hurtTimer.start()
		timer.start()

func _on_timer_timeout() -> void:
	if Global.health <= 100 and Global.health > 0:
		Global.health -= 10
		Global.getHurt = true
		hurtTimer.start()
	else:
		timer.stop()

# Stop the damage when the player exits the goblin's area
func _on_body_exited(body: Node2D) -> void:
	if body.name == "Player" and Global.health <= 100:
		Global.getHurt = false
		hurtTimer.stop()
		timer.stop()

# Reset the hurt state when the hurt timer finishes
func _on_hurt_timer_timeout() -> void:
	Global.getHurt = false
