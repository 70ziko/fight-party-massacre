extends Node2D
# Connect to the character's signal in _ready
func _ready():
	var character = get_node_or_null("../Player")
	if character:
		character.connect("movement_direction_changed", Callable(self, "on_movement_direction_changed"))

# Called by signal from character
func on_movement_direction_changed(dir):
	movement_direction = dir
	print("received event:", dir)
	update()


var bone_color = Color.WHITE
var joint_color = Color.WHITE_SMOKE
var bone_width = 6.0
var joint_radius = 2.0
var head_radius = 12.0

# -1 for left, 1 for right, 0 for idle
var movement_direction := 0

# Call this from the character script
func set_movement_direction(dir):
	movement_direction = dir
	update() # Godot 4.x, for Godot 3.x use: update() -> update()

func update():
	update() # This will call _draw in Godot 3.x

func _draw():
	var skeleton = $"../Skeleton2D"
	if not skeleton:
		return

	draw_line(skeleton.get_node("Hip").global_position, 
		  skeleton.get_node("Hip/Torso").global_position, 
		  bone_color, bone_width)

	# Draw the head (as a circle)
	var head_pos = skeleton.get_node("Hip/Torso/Head").global_position
	draw_circle(head_pos, head_radius, bone_color)

	# Draw neck
	draw_line(skeleton.get_node("Hip/Torso").global_position, 
		skeleton.get_node("Hip/Torso/Head").global_position, 
		bone_color, bone_width)

	# Draw arms
	draw_line(skeleton.get_node("Hip/Torso").global_position, 
		  skeleton.get_node("Hip/Torso/LeftArm").global_position, 
		  bone_color, bone_width)
	draw_line(skeleton.get_node("Hip/Torso/LeftArm").global_position, 
		  skeleton.get_node("Hip/Torso/LeftArm/LeftForearm").global_position, 
		  bone_color, bone_width)

	draw_line(skeleton.get_node("Hip/Torso").global_position, 
		  skeleton.get_node("Hip/Torso/RightArm").global_position, 
		  bone_color, bone_width)
	draw_line(skeleton.get_node("Hip/Torso/RightArm").global_position, 
		  skeleton.get_node("Hip/Torso/RightArm/RightForearm").global_position, 
		  bone_color, bone_width)

	# Draw legs with simple animation: rear leg points more backward
	var hip_pos = skeleton.get_node("Hip").global_position
	var left_leg = skeleton.get_node("Hip/LeftLeg")
	var left_shin = skeleton.get_node("Hip/LeftLeg/LeftShin")
	var right_leg = skeleton.get_node("Hip/RightLeg")
	var right_shin = skeleton.get_node("Hip/RightLeg/RightShin")

	var leg_spread = 0.7 # radians, base angle
	var anim_angle = 0.5 # radians, how much to swing the rear leg

	# Default: legs symmetric
	var left_leg_angle = -leg_spread
	var right_leg_angle = leg_spread

	if movement_direction != 0:
		# The rear leg (opposite to movement) swings more backward
		if movement_direction > 0:
			left_leg_angle -= anim_angle
			right_leg_angle += 0.1
		else:
			right_leg_angle += anim_angle
			left_leg_angle -= 0.1

	# Animate leg positions (for now, just draw lines at angles from hip)
	var leg_length = (left_leg.global_position - hip_pos).length()
	var shin_length = (left_shin.global_position - left_leg.global_position).length()

	# Calculate new leg positions
	var left_leg_end = hip_pos + Vector2(leg_length, 0).rotated(left_leg_angle)
	var left_shin_end = left_leg_end + Vector2(shin_length, 0).rotated(left_leg_angle - 0.2)
	var right_leg_end = hip_pos + Vector2(leg_length, 0).rotated(right_leg_angle)
	var right_shin_end = right_leg_end + Vector2(shin_length, 0).rotated(right_leg_angle + 0.2)

	draw_line(hip_pos, left_leg_end, bone_color, bone_width)
	draw_line(left_leg_end, left_shin_end, bone_color, bone_width)
	draw_line(hip_pos, right_leg_end, bone_color, bone_width)
	draw_line(right_leg_end, right_shin_end, bone_color, bone_width)

	draw_joints(skeleton)

func draw_joints(skeleton):
	var joint_positions = [
		#"Hip",
		#"Hip/Torso",
		"Hip/LeftLeg",
		"Hip/LeftLeg/LeftShin",
		"Hip/RightLeg",
		"Hip/RightLeg/RightShin",
		"Hip/Torso/LeftArm",
		"Hip/Torso/LeftArm/LeftForearm",
		"Hip/Torso/RightArm",
		"Hip/Torso/RightArm/RightForearm"
	]
	
	for path in joint_positions:
		var joint = skeleton.get_node(path)
		draw_circle(joint.global_position, joint_radius, joint_color)

func _process(_delta):
	queue_redraw()
