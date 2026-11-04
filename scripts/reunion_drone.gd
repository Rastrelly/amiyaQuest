class_name reunionDrone extends StaticBody2D

#speceffect death
@export var deathEffect = load("res://scenes/speceffect_explosion.tscn")
@export var bullet = load("res://scenes/generic_bullet.tscn")

#parameters
@export var flyTime:float = 3
@export var hangTime:float = 1.6
@export var gunReload:float = 0.8
@export var flySpeed:float = 70.0
@export var flyDirX:float = -1
@export var activateDist:float = 800

var moveTimer:float = 0
var gunTimer:float = 0

var moveMode:int = -1 #-1 - idle, 0 - fly, 1 - shoot

#damage handling
@export var hp:float = 1.0
@export var isEnemy:bool = true

func take_damage(amt:float):
	hp-=amt
	
func getIsEnemy() -> bool:
	return isEnemy;
	
func checkDead(currHp:float):
	if (currHp <= 0):
		var deathEffectInst = deathEffect.instantiate()
		self.get_parent().add_child(deathEffectInst)
		deathEffectInst.transform = self.transform
		self.queue_free()
		

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#verify is alive
	checkDead(hp)
	
	#process being idle
	if (moveMode == -1):
		if self.position.distance_to(GlobalStateMonitor.playerPos) <= activateDist:
			moveMode = 0
			moveTimer = flyTime
			gunTimer = gunReload
	else:
		if self.position.distance_to(GlobalStateMonitor.playerPos) > activateDist:
			moveMode = -1
	
	#run timerr for movement
	if (moveMode == 0):
		moveTimer -= delta
		if (moveTimer >= 0):
			position.x += flySpeed * flyDirX * delta
		else:
			moveTimer = flyTime
			moveMode = 1
			return
	
	#do stuff with move timer
	if (moveMode == 1):
		moveTimer -= delta
		gunTimer -= delta
		if (moveTimer <= 0):
			moveTimer = hangTime
			moveMode = 0
			return
		if (gunTimer < 0):
			gunTimer = gunReload
			var bulletInst = bullet.instantiate()
			self.get_parent().add_child(bulletInst)
			bulletInst.transform = self.transform
			bulletInst.dir.x = -1
			bulletInst.dir.y = 0.5
