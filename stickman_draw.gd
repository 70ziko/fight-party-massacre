extends Node2D

func _draw():
	var hip = $Skeleton2D/Hip
	var spine = $Skeleton2D/Hip/Spine
	var head = $Skeleton2D/Hip/Spine/Head
	
	draw_line(hip.global_position, spine.global_position, Color.WHITE, 2.0)
	draw_line(spine.global_position, head.global_position, Color.WHITE, 2.0)
	
	draw_circle(head.global_position, 10, Color.WHITE)
	
	draw_line(spine.global_position, $Skeleton2D/Hip/LeftArm.global_position, Color.WHITE, 2.0)
	draw_line(spine.global_position, $Skeleton2D/Hip/RightArm.global_position, Color.WHITE, 2.0)
	draw_line(hip.global_position, $Skeleton2D/Hip/LeftLeg.global_position, Color.WHITE, 2.0)
	draw_line(hip.global_position, $Skeleton2D/Hip/RightLeg.global_position, Color.WHITE, 2.0)

func _process(_delta):
	queue_redraw()
