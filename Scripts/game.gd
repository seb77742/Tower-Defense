extends Node2D

#Global Variabels 
var PlayerHP = 10
var Gold = 0
var Score = 0
var wave = 0
var enemiesleft = 0
var enemieswave = [5,10,20,30,50,0]
var wavespeed = [1,1,0.5,0.5,0.3,100]

var enemy = preload("res://Scenes/enemy.tscn")

func _ready():
	$wavetimer.start()
	
func _on_wavetimer_timeout():
	enemiesleft = enemieswave[wave]
	$enemytimer.wait_time = wavespeed[wave]
	$enemytimer.start()

func _on_enemytimer_timeout():
	var instance = enemy.instantiate()
	$Path2D.add_child(instance)
	enemiesleft -=1
	if enemiesleft <= 0:
		$enemytimer.stop()
		wave +=1
		if wave < len(enemieswave):
			$wavetimer.start()
		else:
			get_tree().change_scene("res://Scenes/win.tscn")
