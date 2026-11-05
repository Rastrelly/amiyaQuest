extends StaticBody2D

@onready var slugSprite: AnimatedSprite2D = $AnimatedSprite2D

@export var slugDeathEffect = load("res://scenes/speceffect_explosion.tscn")
@export var rangeX:float = 100.0
@export var speed:float = 84.0

var halfRange = 0
var pos1 = Vector2(0,0)
var pos2 = Vector2(0,0)
var transitPos:float = 0.5
var transitTime:float = 0.0
var timeDir:int = 1
var timePos:float = 0.0
var hitDmg:float = 4.0

#damage handling
var hp:float = 1.0
var isEnemy:bool = true

func take_damage(amt:float):
	hp-=amt
	
func getIsEnemy() -> bool:
	return isEnemy;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:	
	halfRange = Vector2(0.5*rangeX,0)
	pos1.x = self.position.x - halfRange.x
	pos1.y = self.position.y - halfRange.y
	pos2.x = self.position.x + halfRange.x
	pos2.y = self.position.y + halfRange.y
	transitTime = abs(pos1.x - pos2.x)/speed;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	timePos += timeDir * delta
	if (timePos <= 0) or (timePos >= transitTime):
		timeDir *= -1
	if (timeDir > 0):
		slugSprite.flip_h = false
	else:
		slugSprite.flip_h = true
	transitPos = timePos / transitTime
	var outPosX:float = lerp(pos1.x,pos2.x,transitPos)
	self.position.x = outPosX
	if (hp<=0): 
		var deathEffectInst = slugDeathEffect.instantiate()
		self.get_parent().add_child(deathEffectInst)
		deathEffectInst.transform = self.transform
		self.queue_free()


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_parent().has_method("isEnemy"):
		if not area.get_parent().isEnemy():
			if area.get_parent().has_method("take_damage"):
				area.get_parent().take_damage(hitDmg)
