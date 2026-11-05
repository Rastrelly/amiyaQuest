class_name attack_agent_ranged extends attack_agent_generic

@export var bulletClass = preload("res://scenes/generic_bullet.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Ranged agent spawned at point: ", self.position)
	executeAttack()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func executeAttack() -> void:	
	await get_tree().process_frame
	var bullet = bulletClass.instantiate()
	bullet.dir = dir
	self.get_parent().add_child(bullet)
	bullet.position = self.position
	print("Bullet spawned at point: ", bullet.position)
	
