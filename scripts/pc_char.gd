extends CharacterBody2D

#imported objects (drag on script + ctrl)
@onready var plrSprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var cameraRef: Camera2D = $Camera2D

#define amimi bullet
var amimiBulletClass = load("res://scenes/amimi_bullet.tscn")

#prepare UI
var uiClass = load("res://scenes/main_ui.tscn")


const SPEED = 180.0
const JUMP_VELOCITY = -400.0
const SHOOT_RELOAD_TIME = 0.4
const JUMP_EXTEND_MAX_TIME = 1
const IFRAMES_TIME:float = 0.6
const BLINK_TIME:float = 0.05

var isAttacking:bool = false
var isDead:bool = false
var deathTimePool:float = 5.0
var hp:float = 10.0
var hpMax:float = 10.0

var midair:bool = false

var shootReload:float = 0.0
var jumpExtendTime:float = JUMP_EXTEND_MAX_TIME

var iframesTimer:float = IFRAMES_TIME
var blinkTimer:float = BLINK_TIME
var inIframes:bool = false

var lookDir:float = 1.0

var isEnemy:bool = false

func take_damage(amt:float):
	if (not inIframes):
		inIframes = true
		hp-=amt
		if (hp < 0): hp = 0
		if (hp <= 0): 
			isDead = true
			return
		iframesTimer = IFRAMES_TIME

func getIsEnemy() -> bool:
	return isEnemy;
	

func heal(amt:int)->void:
	hp+=amt
	if (hp > hpMax):
		hp = hpMax


func _ready() -> void:	
	var UI = uiClass.instantiate()	
	cameraRef.add_child.call_deferred(UI)
	GlobalStateMonitor.healPlayer.connect(heal)
	

func _physics_process(delta: float) -> void:
	#report player HP tio global
	GlobalStateMonitor.playerHP = hp
	
	#check if midair
	midair = not is_on_floor()
	
	#handle timers
	shootReload -= delta
	if shootReload < 0.0: shootReload=0.0
	if (isDead):
		deathTimePool -= delta
		
	if (inIframes):
		iframesTimer -= delta
		blinkTimer -= delta
		if (blinkTimer <= 0):
			blinkTimer = BLINK_TIME
			plrSprite.visible = not plrSprite.visible
		if (iframesTimer <= 0):
			plrSprite.visible = true
			inIframes = false
			iframesTimer = IFRAMES_TIME
		
	#reload level if dead
	if (isDead) and (deathTimePool <= 0):
		get_tree().change_scene_to_file("res://scenes/main.tscn")
	
	#Handle anims				
	if (isDead):
		plrSprite.animation = "die"		
	else:
		if abs(velocity.y) != 0:
			plrSprite.animation = "jump"
		
		if (abs(velocity.x)==0 and abs(velocity.y)==0):
			plrSprite.animation = "idle"
		
		if (isAttacking) and (velocity.x == 0):
			plrSprite.animation = "attack"
		
		if (isAttacking) and (velocity.x != 0):
			plrSprite.animation = "run_shoot"
			
		if (not isAttacking) and abs(velocity.x) != 0:
			plrSprite.animation = "run"
		
	#handle sprite flip
	if (velocity.x > 0):
		plrSprite.flip_h = false
		lookDir = 1.0
	if (velocity.x < 0):
		plrSprite.flip_h = true
		lookDir = -1.0
	
	#refresh gjlobal player dir
	GlobalStateMonitor.playerDir = round(lookDir)
	
	# Add the gravity.
	if midair:
		velocity += get_gravity() * delta
	
	if (isDead):
		velocity.x = 0
		move_and_slide()
		return
	
	#handle attack state
	if (Input.is_action_pressed("actAttack")):
		isAttacking = true
	else:
		isAttacking = false
		
	#handle using helpers
	if (Input.is_action_pressed("useHelper0")):
		GlobalHelperController.useHelper(0)
	if (Input.is_action_pressed("useHelper1")):
		GlobalHelperController.useHelper(1)
	if (Input.is_action_pressed("useHelper2")):
		GlobalHelperController.useHelper(2)
		
	# Handle jump
	if not Input.is_action_pressed("moveDown"):
		if Input.is_action_just_pressed("moveJump") and not midair:
			velocity.y = JUMP_VELOCITY
			jumpExtendTime=0.0
			
		if Input.is_action_pressed("moveJump") and midair and jumpExtendTime<JUMP_EXTEND_MAX_TIME and velocity.y < 0:
			jumpExtendTime+=delta
			velocity.y -= abs(get_gravity().y) * 0.4 * delta
	else:
		if Input.is_action_just_pressed("moveJump") and not midair:
			GlobalStateMonitor.jumpDownMode = true
		if Input.is_action_just_released("moveJump"):
			GlobalStateMonitor.jumpDownMode = false
		
	if not Input.is_action_pressed("moveJump") and midair:
		jumpExtendTime=JUMP_EXTEND_MAX_TIME
		
	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("moveLeft", "moveRight")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	#handle attack
	if (isAttacking):
		if (shootReload == 0):
			shootReload = SHOOT_RELOAD_TIME
			var bullet = amimiBulletClass.instantiate()
			bullet.dir.x = lookDir
			bullet.dir.y = 0
			self.get_parent().add_child(bullet)
			bullet.position = self.position
			
	move_and_slide()
	GlobalStateMonitor.player_position.emit(self.position)
