extends StaticBody2D

#damage handling
var hp:float = 1
var isEnemy:bool = true

func take_damage(amt:float):
	hp-=amt
	
func getIsEnemy() -> bool:
	return isEnemy;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (hp<=0):
		self.queue_free()
	


	
