## Receives hits dealt by a HitBoxArea2D
class_name HurtBoxComponent
extends Area2D

## Emitted when receiving a hit.
signal hit_landed(damage)

# Like the HitBoxArea2D, we use the `team` to distinguish the player base from
# enemies.
enum Teams { PLAYER, ENEMY }
@export var team : Teams = Teams.PLAYER

# An entity may have some armor rating, reducing incoming damage.
@export var armor := 0


## Called by `HitBoxArea2D` when it interacts with this hurt box.
func get_hurt(damage: int) -> void:
	var final_damage := damage - armor
	# We emit the final damage as a signal to let other nodes apply it, display
	# it, and so on.
	emit_signal("hit_landed", final_damage)
