extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalStateMonitor.plrRef.get_node("statEffController").addEffect(0,0.45)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
