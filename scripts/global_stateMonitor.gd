extends Node

var playerPos:Vector2
var playerHP:float = 0.0
var playerDir:int = 1
var jumpDownMode:bool = false

signal player_position(player_position: Vector2)
signal healPlayer(amt:int)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player_position.connect(_on_position_change)
	
#should full playerPos var
func _on_position_change(pos:Vector2):
	playerPos = pos


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
