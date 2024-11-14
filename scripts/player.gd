extends CharacterBody2D

@onready var animated_sprite = $AnimatedSprite2D


const SPEED = 300.0
const SPRINT_ACCELERATION = 1.5
const JUMP_VELOCITY = -400.0


func _physics_process(delta: float) -> void:
	
	
	# Add the gravity.
	if not is_on_floor():
		if(Input.is_action_pressed("down")):
			velocity += 3 * (get_gravity() * delta)
		else:
			velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		

	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("left", "right")
		
	if direction:
		animated_sprite.play("walk")
		animated_sprite.flip_h = true
		animated_sprite.play("walk")
		if(Input.is_action_pressed("sprint")):
			velocity.x = direction * (SPEED * SPRINT_ACCELERATION)
		else:
			velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
