extends Node2D

var bone_color = Color.WHITE
var bone_width = 2.0
var head_radius = 10.0

func _draw():
	var skeleton = $"../Skeleton2D"
	
	# Draw torso
	draw_bone(skeleton.get_node("Hip"), skeleton.get_node("Hip/Torso"))
	draw_bone(skeleton.get_node("Hip/Torso"), skeleton.get_node("Hip/Torso/Head"))
	
	# Draw head
	var head_pos = skeleton.get_node("Hip/Torso/Head").global_position
	draw_circle(head_pos, head_radius, bone_color)
	
	# Draw arms
	draw_bone(skeleton.get_node("Hip/Torso/LeftArm"), skeleton.get_node("Hip/Torso/LeftArm/LeftForearm"))
	draw_bone(skeleton.get_node("Hip/Torso/RightArm"), skeleton.get_node("Hip/Torso/RightArm/RightForearm"))
	
	# Draw legs
	draw_bone(skeleton.get_node("Hip/LeftLeg"), skeleton.get_node("Hip/LeftLeg/LeftShin"))
	draw_bone(skeleton.get_node("Hip/RightLeg"), skeleton.get_node("Hip/RightLeg/RightShin"))

func draw_bone(start_bone: Bone2D, end_bone: Bone2D):
	draw_line(start_bone.global_position, end_bone.global_position, bone_color, bone_width)

func _process(_delta):
	queue_redraw()
