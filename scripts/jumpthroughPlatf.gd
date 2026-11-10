extends StaticBody2D

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (GlobalStateMonitor.jumpDownMode):
		collision_shape_2d.one_way_collision_direction = Vector2(0,-1)
	else:
		collision_shape_2d.one_way_collision_direction = Vector2(0,1)
