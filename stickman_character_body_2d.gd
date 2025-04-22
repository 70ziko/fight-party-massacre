extends RigidBody2D

#func _ready():
	# cache skeleton
	#var skel = $Skeleton2D
#
	#for i in range(skel.get_bone_count()):
		#var bone_name = skel.get_child(i).name
		#var phys_bone = PhysicalBone2D.new()
		#phys_bone.skeleton = skel
		#phys_bone.bone_name = bone_name
		#phys_bone.weight = 1.0
		#phys_bone.friction = 0.8
		#phys_bone.gravity_scale = 1.0
		#skel.add_child(phys_bone)

	#skel.physical_bones_active = true

	#mass = 2.0
	#friction = 1.0


func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	var f = Vector2.ZERO
	if Input.is_action_pressed("ui_right"):
		f.x += 500
	if Input.is_action_pressed("ui_left"):
		f.x -= 500
		
	apply_central_force(f)

	# cap max speed
	if linear_velocity.length() > 200:
		linear_velocity = linear_velocity.normalized() * 200
