extends CharacterBody2D

#imported objects (drag on script + ctrl)
@onready var plrSprite: AnimatedSprite2D = $AnimatedSprite2D

#define amimi bullet
var amimiBulletClass = load("res://scenes/amimi_bullet.tscn")


const SPEED = 180.0
const JUMP_VELOCITY = -400.0
const SHOOT_RELOAD_TIME = 0.4
const JUMP_EXTEND_MAX_TIME = 1

var isAttacking:bool = false
var isDead:bool = false
var hp:float = 10.0

var shootReload:float = 0.0
var jumpExtendTime:float = JUMP_EXTEND_MAX_TIME

var lookDir:float = 1.0

var isEnemy:bool = false

func take_damage(amt:float):
	hp-=amt

func getIsEnemy() -> bool:
	return isEnemy;

func _physics_process(delta: float) -> void:
	#handle timers
	shootReload -= delta
	if shootReload < 0.0: shootReload=0.0
	
	#Handle anims
	if abs(velocity.x) != 0:
		plrSprite.animation = "run"
		
	if abs(velocity.y) != 0:
		plrSprite.animation = "jump"
		
	if (abs(velocity.x)==0 and abs(velocity.y)==0):
		plrSprite.animation = "idle"
		
	if (isAttacking):
		plrSprite.animation = "attack"
		
	if (isDead):
		plrSprite.animation = "die"
		
	#handle sprite flip
	if (velocity.x > 0):
		plrSprite.flip_h = false
		lookDir = 1.0
	if (velocity.x < 0):
		plrSprite.flip_h = true
		lookDir = -1.0
		
		
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	#handle attack state
	if (Input.is_action_pressed("actAttack")):
		isAttacking = true
	else:
		isAttacking = false

	if (not isAttacking):
		# Handle jump
		if Input.is_action_just_pressed("moveJump") and is_on_floor():
			velocity.y = JUMP_VELOCITY
			jumpExtendTime=0.0
			
		if Input.is_action_pressed("moveJump") and not is_on_floor() and jumpExtendTime<JUMP_EXTEND_MAX_TIME and velocity.y < 0:
			jumpExtendTime+=delta
			velocity.y -= abs(get_gravity().y) * 0.4 * delta
			
		if not Input.is_action_pressed("moveJump") and not is_on_floor():
			jumpExtendTime=JUMP_EXTEND_MAX_TIME
		
		# Get the input direction and handle the movement/deceleration.
		var direction := Input.get_axis("moveLeft", "moveRight")
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
	else:
		velocity.x = 0
		if (shootReload == 0):
			shootReload = SHOOT_RELOAD_TIME
			var bullet = amimiBulletClass.instantiate()
			bullet.dir.x = lookDir
			bullet.dir.y = 0
			self.get_parent().add_child(bullet)
			bullet.transform = self.transform
	move_and_slide()
