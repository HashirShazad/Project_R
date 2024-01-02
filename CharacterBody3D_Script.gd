extends CharacterBody3D


var speed = 5
var jump_velocity = 4
var friction = .1
var g_multiplier = 1.2

@onready var sprite3d = $AnimatedSprite3D
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")




func _physics_process(delta):
	# sprite flip
	if velocity.x > 1:
		sprite3d.flip_h = 0
	elif velocity.x < -1:
		sprite3d.flip_h = 1
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta * g_multiplier

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_velocity

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, friction)
		velocity.z = move_toward(velocity.z, 0, friction)

	move_and_slide()


	
