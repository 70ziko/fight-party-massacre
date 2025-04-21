extends Node2D

var bone_color = Color.WHITE
var joint_color = Color.WHITE_SMOKE
var bone_width = 6.0
var joint_radius = 2.0
var head_radius = 12.0

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
	
	# Draw legs
	draw_line(skeleton.get_node("Hip").global_position, 
		  skeleton.get_node("Hip/LeftLeg").global_position, 
		  bone_color, bone_width)
	draw_line(skeleton.get_node("Hip/LeftLeg").global_position, 
		  skeleton.get_node("Hip/LeftLeg/LeftShin").global_position, 
		  bone_color, bone_width)
		  
	draw_line(skeleton.get_node("Hip").global_position, 
		  skeleton.get_node("Hip/RightLeg").global_position, 
		  bone_color, bone_width)
	draw_line(skeleton.get_node("Hip/RightLeg").global_position, 
		  skeleton.get_node("Hip/RightLeg/RightShin").global_position, 
		  bone_color, bone_width)
		
		
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
