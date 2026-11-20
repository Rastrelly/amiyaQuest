class_name attack_agent_melee extends attack_agent_generic

@onready var area_2d: Area2D = $Area2D

@export var damage:float = 2
@export var isPlrAttack:bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Melee agent spawned!")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_area_entered(area: Area2D) -> void:
	GlobalFuncLib.checkDamageable(area,isPlrAttack,damage)
