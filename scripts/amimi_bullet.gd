class_name genericBullet extends StaticBody2D

@export var speed:float = 350.0
@export var dir = Vector2(1,0)
@export var lifeTime:float = 1.0
@export var damage:float = 2;
@export var isPlrBullet:bool = true

@export var deathEffect = load("res://scenes/speceffect_explosion_amimi_bullet.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x = position.x + delta * speed * dir.x
	position.y = position.y + delta * speed * dir.y
	lifeTime -= delta
	if lifeTime < 0: self.queue_free()

func playDeathEffect():
	var deathEffectInst = deathEffect.instantiate()
	self.get_parent().add_child(deathEffectInst)
	deathEffectInst.transform = self.transform
	
func die():
	self.queue_free()


func _on_hit_zone_area_entered(area: Area2D) -> void:
	if (area.get_parent().has_method("getIsEnemy")):
		if (area.get_parent().getIsEnemy() == isPlrBullet):
			if (area.get_parent().has_method("take_damage")):
				area.get_parent().take_damage(damage)
				playDeathEffect()
				die()
	else:
		playDeathEffect()
		die()
