class_name genericEnemy extends CharacterBody2D

@onready var sprite: AnimatedSprite2D = $sprite
@onready var hurtbox_area: Area2D = $hurtbox_area


@export var triggerDistance:float = 400
@export var attackDistance:float = 40
@export var speed:float = 220
@export var telegraphTime:float = 0.5
@export var attackTime:float = 0.9

@export var attackAgentClass = load("res://scenes/attack_agent_melee.tscn")
@export var attackAgentSpawnOffset:Vector2 = Vector2(20,0)

var playerDir:float = 0
var currentPurpose:int = 0 #0 - idle, 1 - walk to plr, 2 - telegraph, 3 - attack, 4 - die

var actionTimer:float = 0

#damage handling
@export var hp:float = 1.0
@export var isEnemy:bool = true

func take_damage(amt:float):
	hp-=amt
	
func getIsEnemy() -> bool:
	return isEnemy;
	
#spawns attack agent
func performAttack() -> void:
	var attAg = attackAgentClass.instantiate()
	attAg.dir.x = playerDir
	attAg.dir.y = 0
	self.get_parent().add_child(attAg)
	attAg.position = self.position + attackAgentSpawnOffset * playerDir
	print("Spawning agent at position: ",attAg.position)

func _physics_process(delta: float) -> void:
	#check where the player is
	var pp: Vector2 = GlobalStateMonitor.playerPos
	
	if (pp.x > self.position.x): playerDir = 1
	if (pp.x <= self.position.x): playerDir = -1
	
	var plrDist: float = self.position.distance_to(pp)
	
	#handle purpose for action and state amchine
	if (hp > 0):
		if (plrDist > triggerDistance): currentPurpose = 0
		if (plrDist <= triggerDistance):
			if (plrDist > attackDistance) and (actionTimer <= 0): #run to player
				velocity.x = playerDir * speed
				currentPurpose = 1
			if (plrDist <= attackDistance) or (actionTimer > 0): #attack player
				velocity.x = 0
				if (currentPurpose != 2) and (currentPurpose !=3):
					currentPurpose = 2
					actionTimer = telegraphTime
					print("Ini tele on strt")
				if (actionTimer <= 0):
					if currentPurpose == 2: 
						currentPurpose = 3
						actionTimer = attackTime
						performAttack()
						print("end tele, do attack")
					else:
						currentPurpose = 2
						actionTimer = telegraphTime
						print("end attack do tele")
	else:
		velocity.x = 0
		currentPurpose = 4
		self.collision_layer=0b00000000000000000000
		self.collision_mask=0b00000000000000000001
		hurtbox_area.collision_layer=0b00000000000000000000
		hurtbox_area.collision_mask=0b00000000000000000000
	
	#handle attack timer
	if (actionTimer > 0):
		actionTimer -= delta
		
	#print("CurrPurp ",currentPurpose,"; tmr = ",actionTimer)
	
	#handle gravity
	if (not is_on_floor()):
		velocity += get_gravity() * delta
	
	#handle animations
	if (currentPurpose == 0):
		if (sprite.animation != "idle"):
			sprite.animation = "idle"
	if (currentPurpose == 1):
		if (sprite.animation != "walk"):
			sprite.animation = "walk"
	if (currentPurpose == 2):
		if (sprite.animation != "telegraph"):
			sprite.animation = "telegraph"
			sprite.play()
	if (currentPurpose == 3):
		if (sprite.animation != "attack"):
			sprite.animation = "attack"
			sprite.play()
	if (currentPurpose == 4):
		if (sprite.animation != "death"):
			sprite.animation = "death"
			sprite.play()
	
	if (hp > 0):
		if (playerDir > 0): sprite.flip_h = false
		else: sprite.flip_h = true

	move_and_slide()
