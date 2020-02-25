extends Area2D

signal hit

export var speed = 400 		# How fast the player will move (pixels/sec).
var screen_size 		# Size of the window.
# Add this variable to hold the clicked position.
var target = Vector2()

func _ready():
	screen_size = get_viewport_rect().size
	hide()


func _process(delta):
	var velocity = Vector2()		# The player's movement vector
	
	# Move towards the target and stop when close.
	if position.distance_to(target) > 10:
		velocity = (target - position).normalized() * speed
	else:
		velocity = Vector2()
	
# Remove keyboard controls
#	if Input.is_action_pressed("ui_right"):
#		velocity.x += 1
#	if Input.is_action_pressed("ui_left"):
#		velocity.x -= 1
	# Different from tutorial, ok, I am wrong
#	if Input.is_action_pressed("ui_down"):
#		velocity.y += 1
#	if Input.is_action_pressed("ui_up"):
#		velocity.y -= 1
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()
	
	position += velocity * delta
	# We don't need to clamp the player's position
	# because you can't click outisde the screen
#	position.x = clamp(position.x, 0, screen_size.x)
#	position.y = clamp(position.y, 0, screen_size.y)
	
	# Below are the shorthand version of boolean assignments
	if velocity.x != 0:
		$AnimatedSprite.animation = "right"
		$AnimatedSprite.flip_v = false
		$AnimatedSprite.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite.animation = "up"
		$AnimatedSprite.flip_v = velocity.y > 0


func start(pos):
	position = pos
	# Initial target is the start position.
	target = pos
	show()
	$CollisionShape2D.disabled = false

# Change the target whenever a touch event happens.
func _input(event):
	if event is InputEventScreenTouch and event.pressed:
		target = event.position















func _on_Player_body_entered(body):
	hide()		# Player disappears after being hit
	emit_signal("hit")
	# set_deferred is so that Godot will disable to shape
	# until it's safe to do so
	$CollisionShape2D.set_deferred("disabled", true)
