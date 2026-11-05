class_name attack_agent_melee extends attack_agent_generic

@onready var area_2d: Area2D = $Area2D

@export var damage:float = 2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Melee agent spawned!")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_area_entered(area: Area2D) -> void:
	if (area.get_parent().has_method("getIsEnemy")):
		if (area.get_parent().getIsEnemy() == false):
			if (area.get_parent().has_method("take_damage")):
				area.get_parent().take_damage(damage)
				print("Dealing damage!")
				self.queue_free()
