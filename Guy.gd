extends CharacterBody2D
class_name Guy

@export var move_speed= 100
@export var gravity= 50

@onready var bow_offset: Node2D = $"Bow Offset"
@onready var bow: Bow = $"Bow Offset/Bow"
@onready var left_arm = $"Visual/Left Arm"
@onready var right_arm = $"Visual/Right Arm"

func _process(delta):
	# left hand is the second point on the left_arm Line node and
	# it should always follow the bow hand_connector node
	left_arm.points[1]= to_local(bow.hand_connector.global_position)
	
	# rotate the Bow with the mouse
	bow_offset.look_at(get_global_mouse_position())


func _physics_process(delta):
	# move the player
	velocity.x= Input.get_axis("ui_left", "ui_right") * move_speed
	velocity.y+= gravity * delta
	
	move_and_slide()

	# when the left mouse button is pressed initially equip the Arrow
	if Input.is_action_just_pressed("left_mouse"):
		bow.equip_arrow()
	# keep pulling on the Bow while holding left mouse button
	if Input.is_action_pressed("left_mouse"):
		bow.pull(delta)
	# and shoot when released
	if Input.is_action_just_released("left_mouse"):
		bow.shoot()
	
