extends Node2D


var enemies = []
var current_enemy

func _physics_process(delta):
	if enemies != []:
		current_enemy = enemies[0]
		
func _on_sight_area_entered(area):
	if area.is_in_group("Enemy"):
		enemies.append(area)


func _on_sight_area_exited(area):
	if area.is_in_group("Enemy"):
		enemies.erase(area)


