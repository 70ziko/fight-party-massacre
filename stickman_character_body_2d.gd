extends RigidBody2D

func _ready():
	# Enable Godot's built-in bone physics (ragdoll)
	var skel = $Skeleton2D
	if skel.has_method("set_physical_bones_active"):
		skel.set_physical_bones_active(true)
