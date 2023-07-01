class_name HitBoxComponent
extends Area2D


enum Teams {PLAYER, ENEMY} 
@export var team : Teams = Teams.PLAYER
@export var health_component : int
@export var damage_value := 1
## If `true`, this hitbox can deal damage to multiple targets.
@export var can_hit_multiple := false


#func damage(attack):
	#if health_component == true:
		#health_component.damage(attack)
	#pass

func _on_area_entered(area):
	apply_hit(area)
	pass # Replace with function body.


func apply_hit(hurt_box: HurtBoxComponent) -> void:
	if team == hurt_box.team:
		return
	# We have yet to create the hurt box but we'll define a `get_hurt()` method
	# on it to receive damage.
	hurt_box.get_hurt(damage_value)

	# If this hitbox can only hit one target, we turn off its `monitoring`
	# property.
	# We use `set_deferred()` to do so because we can't toggle the property
	# while the engine is processing physics.
	set_deferred("monitoring", can_hit_multiple)
