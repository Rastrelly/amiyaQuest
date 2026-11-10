extends Node

#checks if node has getIsEnemy and take_damage methods; compares checkState against getIsEnemy
#and proceeds if true. applies dmgAmt via take_damage, so set to 0 is needs only to check
func checkDamageable(obj:Node2D, checkState:bool, dmgAmt: float) -> bool:
	if (obj.get_parent().has_method("getIsEnemy")):
		if (obj.get_parent().getIsEnemy() == checkState):
			if (obj.get_parent().has_method("take_damage")):
				obj.get_parent().take_damage(dmgAmt)
				return true
			else:
				return false
		else:
			return false
	else:
		return true

#spawns speceffects cene node ad point; probably can spawn any node, needs testing
func spawnSpeceffectAtPoint(path:String, pos: Vector2, scale: Vector2) -> void:
	var se = load(path)
	var seInst = se.instantiate()
	get_tree().current_scene.add_child(seInst)
	seInst.position = pos
	seInst.scale = scale

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
