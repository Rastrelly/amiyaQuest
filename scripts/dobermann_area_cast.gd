class_name doberWhipAreaCast extends Area2D

var castLength:float = 200
var dobermannWhipDamage = 2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("dobermann area cast spawned at ",self.position)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_area_entered(area: Area2D) -> void:
	GlobalFuncLib.checkDamageable(area,true,dobermannWhipDamage)
