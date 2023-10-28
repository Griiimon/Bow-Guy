# add this utility script to a Polygon2D node to create a
# CollisionPolygon with the same shape at runtime
extends Polygon2D

func _ready():
	assert(get_parent() is CollisionObject2D, "parent node needs to be of type CollisionObject2D")
	await get_parent().ready
	
	var shape= CollisionPolygon2D.new()
	shape.polygon= polygon
	shape.position= position
	add_sibling(shape)
