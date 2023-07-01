extends PathFollow2D

var health = 5
var speed = 30

func _physics_process(delta):
	h_offset += speed*delta
	if h_offset >= 10000:
		queue_free()
