extends Node2D

var wave = 0
var enemiesleft = 0
var enemieswave = [5,10,20,30,50,0]
var wavespeed = [1,1,0.5,0.5,0.3,100]
@onready var stimer = get_node("player/shoottimer") 

var enemy = preload("res://modules/enemy/enemy.tscn")

func _ready():
	GVariabel.PlayerHP = 10
	$wavetimer.start()
	
func _process(delta):
	$Gold.text = "Gold: " + str(GVariabel.Gold)
	$PlayerHP.text = "HP: " + str(GVariabel.PlayerHP)
	$Fre.text = "Fre: " + str(stimer.wait_time)

func _on_wavetimer_timeout():
	enemiesleft = enemieswave[wave]
	$enemytimer.wait_time = wavespeed[wave]
	$enemytimer.start()

func _on_enemytimer_timeout():
	var instance = enemy.instantiate()
	var rng = RandomNumberGenerator.new()
	var ranint = rng.randi_range(0, 360)
	var x = $player.position.x + 450 * cos(ranint)
	var y = $player.position.y + 450 * sin(ranint)
	instance.position = Vector2(x,y)
	add_child(instance)
	enemiesleft -=1
	if enemiesleft <= 0:
		$enemytimer.stop()
		wave +=1
		if wave < len(enemieswave):
			$wavetimer.start()
		else:
			get_tree().change_scene("res://modules/win,main/win.tscn")
			
func _draw():
	var color = Color(1.0, 0.0, 0.0)
	draw_arc($player.position,GVariabel.towerradius, 0, TAU, 1000, color,1.0, true)


func _on_bulletspeed_pressed():
	if GVariabel.Gold >= 10:
		GVariabel.Gold -=10
		stimer.wait_time -= 0.05
		

func _on_raduis_pressed():
	if GVariabel.Gold >= 10:
		GVariabel.Gold -=10
		GVariabel.towerradius +=10
		#redraw circle
		queue_redraw() 
		#resize collisionshape sight
		get_node("player/Sight/CollisionSight").shape.radius = GVariabel.towerradius
