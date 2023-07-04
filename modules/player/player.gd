extends Node2D

var bullet = preload("res://modules/bullet/bullet.tscn") 
var enemies = []
var current_enemy

func _ready():
	$Sight/CollisionSight.shape.radius = GVariabel.towerradius
	
func _physics_process(delta):
	if enemies != []:
		current_enemy = enemies[0]
		
	if GVariabel.PlayerHP <= 0:
		get_tree().change_scene_to_file("res://modules/win,main/main.tscn")
		
func _on_sight_body_entered(body):
	if body.is_in_group("Enemy"):
		enemies.append(body)
		
func _on_sight_body_exited(body):
	if body.is_in_group("Enemy"):
		enemies.erase(body)

func _on_shoottimer_timeout():
	if current_enemy:
		if enemies:
			if current_enemy == enemies[0]:
				var b = bullet.instantiate()
				b.global_position = global_position
				b.target = current_enemy
				get_parent().add_child(b)


