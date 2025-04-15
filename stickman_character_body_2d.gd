extends CharacterBody2D

var speed = 300.0
var jump_velocity = -400.0
var gravity = 980

var health = 100
var is_attacking = false
var direction = 1  # 1 for right, -1 for left

func _ready():
	setup_skeleton()

func setup_skeleton():
	var capsule = CapsuleShape2D.new()
	capsule.radius = 16
	capsule.height = 48
	$CollisionShape2D.shape = capsule

	# Setup bones initial positions
	$Skeleton2D/Hip.position = Vector2(0, 0)
	$Skeleton2D/Hip/Spine.position = Vector2(0, -20)
	$Skeleton2D/Hip/Spine/Head.position = Vector2(0, -20)
	$Skeleton2D/Hip/LeftLeg.position = Vector2(-10, 10)
	$Skeleton2D/Hip/RightLeg.position = Vector2(10, 10)
	$Skeleton2D/Hip/Spine/LeftArm.position = Vector2(-15, -15)
	$Skeleton2D/Hip/Spine/RightArm.position = Vector2(15, -15)


func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity

	# TODO: change to joystick analog directions
	var input_direction = Input.get_axis("move_left", "move_right")
	if input_direction:
		velocity.x = input_direction * speed
		direction = 1 if input_direction > 0 else -1
		$Sprite2D.flip_h = (direction < 0)
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()
