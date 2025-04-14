extends CollisionShape2D
func _draw():
	# Draw head
	draw_circle(Vector2(0, -20), 10, Color.WHITE)
	
	# Draw body
	draw_line(Vector2(0, -10), Vector2(0, 20), Color.WHITE, 2.0)
	
	# Draw arms
	draw_line(Vector2(0, 0), Vector2(-15, 10), Color.WHITE, 2.0)
	draw_line(Vector2(0, 0), Vector2(15, 10), Color.WHITE, 2.0)
	
	# Draw legs
	draw_line(Vector2(0, 20), Vector2(-10, 40), Color.WHITE, 2.0)
	draw_line(Vector2(0, 20), Vector2(10, 40), Color.WHITE, 2.0)
