extends Node2D

var wave = 0
var enemiesleft = 0
var enemieswave = [5,10,20,30,50,0]
var wavespeed = [1,1,0.5,0.5,0.3,100]

var radius = 300

var enemy = preload("res://modules/enemy/enemy.tscn")

func _ready():
	GVariabel.PlayerHP = 10
	$wavetimer.start()
	
func _process(delta):
	$Gold.text = "Gold: " + str(GVariabel.Gold)
	$PlayerHP.text = "HP: " + str(GVariabel.PlayerHP)

func _on_wavetimer_timeout():
	enemiesleft = enemieswave[wave]
	$enemytimer.wait_time = wavespeed[wave]
	$enemytimer.start()

func _on_enemytimer_timeout():
	var instance = enemy.instantiate()
	var rng = RandomNumberGenerator.new()
	var ranint = rng.randi_range(0, 360)
	var x = $player.position.x + radius * cos(ranint)
	var y = $player.position.y + radius * sin(ranint)
	instance.position = Vector2(x,y)
	add_child(instance)
	enemiesleft -=1
	if enemiesleft <= 0:
		$enemytimer.stop()
		wave +=1
		if wave < len(enemieswave):
			$wavetimer.start()
		else:
			get_tree().change_scene("res://Scenes/win.tscn")
			
			
func _draw():
	var color = Color(1.0, 0.0, 0.0)
	draw_arc($player.position,radius, 0, TAU, 1000, color)
