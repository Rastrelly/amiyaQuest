extends StaticBody2D

var speed:float = 350.0
var dir = Vector2(1,0)
var lifeTime:float = 1.0
var damage:float = 2;
var isPlrBullet:bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x = position.x + delta * speed * dir.x
	position.y = position.y + delta * speed * dir.y
	lifeTime -= delta
	if lifeTime < 0: self.queue_free()


func _on_hit_zone_area_entered(area: Area2D) -> void:
	self.queue_free()
	if (area.get_parent().has_method("getIsEnemy")):
		if (area.get_parent().getIsEnemy()):
			if (area.get_parent().has_method("take_damage")):
				area.get_parent().take_damage(2)
