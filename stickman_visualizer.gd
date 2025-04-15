extends Node2D

var bone_color = Color.WHITE
var joint_color = Color.RED
var bone_width = 2.0
var joint_radius = 3.0

func _draw():
    var skeleton = $"../Skeleton2D"
    if not skeleton:
        return
        
    # Draw all bones recursively
    draw_bone_recursive(skeleton.get_node("Hip"))
    
    # Draw joints
    draw_joints(skeleton.get_node("Hip"))

func draw_bone_recursive(bone: Bone2D):
    for child in bone.get_children():
        if child is Bone2D:
            draw_line(bone.global_position, child.global_position, bone_color, bone_width)
            draw_bone_recursive(child)

func draw_joints(bone: Bone2D):
    draw_circle(bone.global_position, joint_radius, joint_color)
    for child in bone.get_children():
        if child is Bone2D:
            draw_joints(child)

func _process(_delta):
    queue_redraw()