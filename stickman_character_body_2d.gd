extends CharacterBody2D

var gravity: float = float(ProjectSettings.get_setting("physics/2d/default_gravity"))

func _ready():
	var skel = $Skeleton2D
	print("Godot version:", Engine.get_version_info())
	if skel.has_method("set_physical_bones_active"):
		skel.set_physical_bones_active(true)
		print("Physical bones activated for skeleton: ", skel)
	else:
		print("Skeleton2D does not support physical bones!")
	_recursive_print_bones(skel)

func _physics_process(delta):
	print(position.y)
	if position.y <= 490:
		velocity.y += gravity * delta
	else:
		velocity.y = 0
	move_and_slide()

func _recursive_print_bones(node):
	if node is PhysicalBone2D:
		print("Found PhysicalBone2D: ", node.get_path())
		for child in node.get_children():
			if child is CollisionShape2D:
				print("  Has CollisionShape2D: ", child.shape)
	for child in node.get_children():
		_recursive_print_bones(child)
