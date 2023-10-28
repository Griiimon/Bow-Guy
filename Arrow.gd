extends CharacterBody2D
class_name Arrow

@export var gravity= 10

# Arrow is spawned on the Bow while drawing, so dont run any logic yet
func _ready():
	set_physics_process(false)


func _physics_process(delta):
	# always look in the direction its going
	if velocity:
		look_at(global_position + velocity.normalized())
	
	# add gravity
	velocity.y+= gravity * delta

	move_and_collide(velocity * delta)

# if the area at the tip of the Arrow detects a collision
# disable Arrow logic, stop tip Area from scanning anymore
# and reparent to the hit body ( make Arrow stick to it ) 
func _on_area_2d_body_entered(body):
	set_physics_process(false)
	$Area2D.queue_free()
	reparent.call_deferred(body)
