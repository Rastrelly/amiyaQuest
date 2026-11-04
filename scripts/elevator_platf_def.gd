class_name elevator_platf_def extends AnimatableBody2D

@export var deltaH:float = 300.0
@export var speed:float = 120.0
@export var startPoint2:bool = false

var p1:Vector2 = Vector2(0,0)
var p2:Vector2 = Vector2(0,0)

var moveT:float = 0.0
var moveTimer:float = 0.0
var moveDir:float = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	p1 = self.position
	p2 = self.position + Vector2(0,deltaH)
	moveT = deltaH/speed
	moveTimer = moveT
	if (startPoint2):
		self.position = p2
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	moveTimer -= delta
	if (moveTimer > 0):
		if (moveDir == 1):
			self.position = lerp(p1,p2,moveTimer/moveT)
		else:
			self.position = lerp(p2,p1,moveTimer/moveT)
	else:
		moveDir *= -1
		moveTimer = moveT
			
		
