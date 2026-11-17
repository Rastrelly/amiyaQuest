extends Area2D

var lifePool:float = 0.8


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	lifePool -= delta
	if (lifePool <= 0.0 and not is_queued_for_deletion()):
		queue_free()
