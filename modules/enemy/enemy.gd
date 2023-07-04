extends CharacterBody2D

var speed = 30
var health = 2
func _physics_process(delta):

		var player =get_node("../player")
		var direction = (player.position - self.position).normalized()
		velocity = direction * speed
		
		move_and_slide()


func _on_bullet_collision_area_entered(area):
	if area.is_in_group("Projectile"):
		area.queue_free() # Erase Bullet
		health -=1
		if health <= 0:
			GVariabel.Gold += 10
			GVariabel.Score += 1
			self.queue_free()
			
	if area.is_in_group("Player"):
		health = 0
		if health <= 0:
			GVariabel.PlayerHP -=1
			self.queue_free()

