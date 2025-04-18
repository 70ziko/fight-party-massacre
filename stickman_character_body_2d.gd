extends CharacterBody2D

var speed = 300.0
var jump_velocity = -400.0
var gravity = 980

var health = 100
var is_attacking = false
var direction = 1  # 1 for right, -1 for left


func _ready():
	setup_collision()
	print("Character initialized")
	print_skeleton_structure($Skeleton2D)

func print_skeleton_structure(node: Node, indent: String = ""):
	print(indent + node.name)
	for child in node.get_children():
		print_skeleton_structure(child, indent + "  ")

func setup_collision():
	var capsule = CapsuleShape2D.new()
	capsule.radius = 16
	capsule.height = 48
	$CollisionShape2D.shape = capsule

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = jump_velocity

	# TODO: change to joystick analog directions
	var input_direction = Input.get_axis("ui_left", "ui_right")
	if input_direction:
		velocity.x = input_direction * speed
		direction = 1 if input_direction > 0 else -1
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()


func _process(_delta):
	# Update bone rotations based on movement
	var skeleton = $Skeleton2D
	var movement_factor = velocity.x / speed
	
	# Leg swing
	skeleton.get_node("Hip/LeftLeg").rotation = sin(Time.get_ticks_msec() * 0.01) * movement_factor * 0.5
	skeleton.get_node("Hip/RightLeg").rotation = -sin(Time.get_ticks_msec() * 0.01) * movement_factor * 0.5
	
	# Arm swing
	skeleton.get_node("Hip/Torso/LeftArm").rotation = -sin(Time.get_ticks_msec() * 0.01) * movement_factor * 0.5
	skeleton.get_node("Hip/Torso/RightArm").rotation = sin(Time.get_ticks_msec() * 0.01) * movement_factor * 0.5
