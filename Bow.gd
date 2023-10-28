extends Node2D
class_name Bow

@export var max_pull_length= 10
@export var shoot_force= 50
@onready var ArrowScene= preload("res://arrow.tscn")

@onready var bow_string = $String
@onready var hand_connector = $"Hand Connector"

var arrow: Arrow
var pull_length: float

# the bow string Line Node has 3 points, the middle point is moved 
# while drawing so it looks like the player is pulling the string
func _process(delta):
	bow_string.points[1].x= -pull_length
	
# spawn an Arrow on the bow in the correct position
func equip_arrow():
	arrow= ArrowScene.instantiate()
	arrow.position= hand_connector.position
	add_child(arrow)

# called while drawing
func pull(delta):
	# clamp pull_length to max_pull_length
	pull_length= min(pull_length + delta * 10, max_pull_length)
	arrow.position.x= hand_connector.position.x - pull_length + 10

func shoot():
	# arrow velocity depends on the pull_length and shoot_force export var
	arrow.velocity= global_transform.x * pull_length * shoot_force
	# remove Arrow as child of the Bow and make child of the Level node
	arrow.reparent(get_tree().root)
	# enable Arrow logic
	arrow.set_physics_process(true)
	# Bow has no Arrow anymore
	arrow= null
	
	pull_length= 0

func get_string_center()-> Vector2:
	return to_global(bow_string.points[1])
