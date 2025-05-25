extends RigidBody2D

func _ready():
	var skel = $Skeleton2D
	print("Godot version:", Engine.get_version_info())
	# print("Skeleton2D methods:", skel.get_method_list())

	# Try to enable physical bones if possible
	if skel.has_method("set_physical_bones_active"):
		skel.set_physical_bones_active(true)
		print("Physical bones activated for skeleton: ", skel)
	else:
		print("Skeleton2D does not support physical bones!")
	
	# skel.physical_bone_chain_length(2)

	# Recursively print all PhysicalBone2D nodes and their CollisionShape2D children
	_recursive_print_bones(skel)


func _recursive_print_bones(node):
	if node is PhysicalBone2D:
		print("Found PhysicalBone2D: ", node.get_path())
		for child in node.get_children():
			if child is CollisionShape2D:
				print("  Has CollisionShape2D: ", child.shape)
	for child in node.get_children():
		_recursive_print_bones(child)
