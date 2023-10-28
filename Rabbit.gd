extends CharacterBody2D

@export var move_speed= 100
@export var gravity= 500

var dir:= 1

func _physics_process(delta):
	# move in given direction (-1 => left, 0 => not, 1 => right)
	velocity.x= dir * move_speed

	velocity.y+= gravity
		
	move_and_slide()

# when the Direction Change Timer times out randomly assign new direction
func _on_direction_change_timeout():
	# pick random value from [-1, 0, 1]
	dir= randi_range(-1, 1)
	# randomize Direction Change Timer wait time too
	$"Direction Change".wait_time= randi_range(2, 5)
	$"Direction Change".start()
