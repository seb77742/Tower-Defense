extends Area2D

var move = Vector2.ZERO
var look_vec = Vector2.ZERO
var target

func _ready():
	if target !=  null:
		self.look_at(target.global_position)
		look_vec = target.global_position - global_position

func _physics_process(delta):
	move = Vector2.ZERO
	
	move = move.move_toward(look_vec, delta)
	move = move.normalized() * GVariabel.bulletspeed
	global_position += move


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
