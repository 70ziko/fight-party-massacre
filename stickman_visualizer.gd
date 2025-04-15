extends Node2D

var bone_color = Color.WHITE
var joint_color = Color.RED
var bone_width = 2.0
var joint_radius = 3.0

func _draw():
	var skeleton = $"../Skeleton2D"
	if not skeleton:
		return
		
	# Draw bones
	draw_bone_chain("Hip/Torso/Head")
	draw_bone_chain("Hip/Torso/LeftArm/LeftForearm")
	draw_bone_chain("Hip/Torso/RightArm/RightForearm")
	draw_bone_chain("Hip/LeftLeg/LeftShin")
	draw_bone_chain("Hip/RightLeg/RightShin")
	
	# Draw joints
	draw_joints(skeleton)

func draw_bone_chain(path: String):
	var skeleton = $"../Skeleton2D"
	var bones = path.split("/")
	var current_node = skeleton
	
	for i in range(len(bones) - 1):
		current_node = current_node.get_node(bones[i])
		var next_node = current_node.get_node(bones[i + 1])
		draw_line(current_node.global_position, next_node.global_position, 
				 bone_color, bone_width)

func draw_joints(skeleton: Node2D):
	for bone in skeleton.get_children():
		if bone is Bone2D:
			draw_circle(bone.global_position, joint_radius, joint_color)
			_draw_joints_recursive(bone)

func _draw_joints_recursive(bone: Node2D):
	for child in bone.get_children():
		if child is Bone2D:
			draw_circle(child.global_position, joint_radius, joint_color)
			_draw_joints_recursive(child)

func _process(_delta):
	queue_redraw()
