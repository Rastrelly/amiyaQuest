class_name speceffect extends Node2D

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sprite.play("default",1,false)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _speceffect_finished() -> void:
	print("Killing effect...")
	self.queue_free()
