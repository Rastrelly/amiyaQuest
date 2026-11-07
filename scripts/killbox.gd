extends Area2D

@export var size:Vector2 = Vector2(16, 16)
@export var dmg:float = 100

@onready var collision_shape: CollisionShape2D = $CollisionShape

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	collision_shape.shape.size = size  	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_entered(area: Area2D) -> void:
	GlobalFuncLib.checkDamageable(area,false,dmg)
