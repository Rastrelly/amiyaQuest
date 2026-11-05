class_name attack_agent_generic extends Node2D

@export var dir:Vector2 = Vector2(1,0)
@export var spawnPos:Vector2 = Vector2(0,0)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:	
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


#attack agents main func; must be overridden by children to actually work
func executeAttack() -> void:
	pass
