extends Node2D

# Helper to get bone position (class scope)
func bone_pos(path):
	var skeleton = get_node_or_null("../Skeleton2D")
	if not skeleton:
		return Vector2.ZERO
	var node = skeleton.get_node_or_null(path)
	if not node:
		return Vector2.ZERO
	return node.global_position

var bone_color = Color.WHITE
var joint_color = Color.WHITE_SMOKE
var bone_width = 6.0
var joint_radius = 2.0
var head_radius = 12.0

func _draw():
	var skeleton = $"../Skeleton2D"
	if not skeleton:
		return

	# Get movement direction from parent (CharacterBody2D)
	var movement_direction := 0
	var parent = get_parent()
	if parent and ("movement_direction" in parent):
		movement_direction = parent.movement_direction

	# Helper to get bone position
	# Helper to get bone position (as a local function)
	# GDScript does not support local functions, so use a lambda assigned to a variable
	# Use a lambda for bone_pos
	# Helper to get bone position (define as a regular function, not a lambda)
	# Use bone_pos as a method on self
	# Calculate offsets for simple animation
	var torso_offset_draw = Vector2(6 * movement_direction, -2 * abs(movement_direction))

	# Use the lambda with .call(path)
	var hip_draw = self.bone_pos("Hip")
	var torso_draw = self.bone_pos("Hip/Torso") + torso_offset_draw
	draw_line(hip_draw, torso_draw, bone_color, bone_width)

	# Head
	var head_pos_draw = self.bone_pos("Hip/Torso/Head") + torso_offset_draw
	draw_circle(head_pos_draw, head_radius, bone_color)

	# Neck
	draw_line(torso_draw, head_pos_draw, bone_color, bone_width)

	# Arms
	var left_arm_draw = self.bone_pos("Hip/Torso/LeftArm") + torso_offset_draw
	var left_forearm_draw = self.bone_pos("Hip/Torso/LeftArm/LeftForearm") + torso_offset_draw
	var right_arm_draw = self.bone_pos("Hip/Torso/RightArm") + torso_offset_draw
	var right_forearm_draw = self.bone_pos("Hip/Torso/RightArm/RightForearm") + torso_offset_draw
	draw_line(torso_draw, left_arm_draw, bone_color, bone_width)
	draw_line(left_arm_draw, left_forearm_draw, bone_color, bone_width)
	draw_line(torso_draw, right_arm_draw, bone_color, bone_width)
	draw_line(right_arm_draw, right_forearm_draw, bone_color, bone_width)

	# Legs
	var left_leg_draw = self.bone_pos("Hip/LeftLeg")
	var left_shin_draw = self.bone_pos("Hip/LeftLeg/LeftShin")
	var right_leg_draw = self.bone_pos("Hip/RightLeg")
	var right_shin_draw = self.bone_pos("Hip/RightLeg/RightShin")

	# Flip rear leg depending on direction
	if movement_direction != 0:
		# Assume left leg is rear when moving right, right leg is rear when moving left
		if movement_direction > 0:
			# Moving right: left leg is rear, flip it back
			left_leg_draw += Vector2(-8, 8)
			left_shin_draw += Vector2(-8, 8)
		elif movement_direction < 0:
			# Moving left: right leg is rear, flip it back
			right_leg_draw += Vector2(8, 8)
			right_shin_draw += Vector2(8, 8)

	draw_line(hip_draw, left_leg_draw, bone_color, bone_width)
	draw_line(left_leg_draw, left_shin_draw, bone_color, bone_width)
	draw_line(hip_draw, right_leg_draw, bone_color, bone_width)
	draw_line(right_leg_draw, right_shin_draw, bone_color, bone_width)

	# Calculate offsets for simple animation
	var torso_offset = Vector2(6 * movement_direction, -2 * abs(movement_direction))

	# Hip and torso
	var hip = bone_pos("Hip")
	var torso = bone_pos("Hip/Torso") + torso_offset
	draw_line(hip, torso, bone_color, bone_width)

	# Head
	var head_pos = bone_pos("Hip/Torso/Head") + torso_offset
	draw_circle(head_pos, head_radius, bone_color)

	# Neck
	draw_line(torso, head_pos, bone_color, bone_width)

	# Arms
	var left_arm = bone_pos("Hip/Torso/LeftArm") + torso_offset
	var left_forearm = bone_pos("Hip/Torso/LeftArm/LeftForearm") + torso_offset
	var right_arm = bone_pos("Hip/Torso/RightArm") + torso_offset
	var right_forearm = bone_pos("Hip/Torso/RightArm/RightForearm") + torso_offset
	draw_line(torso, left_arm, bone_color, bone_width)
	draw_line(left_arm, left_forearm, bone_color, bone_width)
	draw_line(torso, right_arm, bone_color, bone_width)
	draw_line(right_arm, right_forearm, bone_color, bone_width)

	# Legs
	var left_leg = bone_pos("Hip/LeftLeg")
	var left_shin = bone_pos("Hip/LeftLeg/LeftShin")
	var right_leg = bone_pos("Hip/RightLeg")
	var right_shin = bone_pos("Hip/RightLeg/RightShin")

	# Flip rear leg depending on direction
	if movement_direction != 0:
		# Assume left leg is rear when moving right, right leg is rear when moving left
		if movement_direction > 0:
			# Moving right: left leg is rear, flip it back
			left_leg += Vector2(-8, 8)
			left_shin += Vector2(-8, 8)
		elif movement_direction < 0:
			# Moving left: right leg is rear, flip it back
			right_leg += Vector2(8, 8)
			right_shin += Vector2(8, 8)

	draw_line(hip, left_leg, bone_color, bone_width)
	draw_line(left_leg, left_shin, bone_color, bone_width)
	draw_line(hip, right_leg, bone_color, bone_width)
	draw_line(right_leg, right_shin, bone_color, bone_width)
# 	draw_joints(skeleton)

# func draw_joints(skeleton):
# 	var joint_positions = [
# 		#"Hip",
# 		#"Hip/Torso",
# 		"Hip/LeftLeg",
# 		"Hip/LeftLeg/LeftShin",
# 		"Hip/RightLeg",
# 		"Hip/RightLeg/RightShin",
# 		"Hip/Torso/LeftArm",
# 		"Hip/Torso/LeftArm/LeftForearm",
# 		"Hip/Torso/RightArm",
# 		"Hip/Torso/RightArm/RightForearm"
# 	]
	
# 	for path in joint_positions:
# 		var joint = skeleton.get_node(path)
# 		draw_circle(joint.global_position, joint_radius, joint_color)

func _process(_delta):
	queue_redraw()
