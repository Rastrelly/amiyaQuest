extends Control

@onready var ui_cont: AspectRatioContainer = $uiCont
@onready var label_hp: Label = $labelHP
@onready var label_death: Label = $labelDeath

var scrSize:Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	scrSize = get_viewport().get_visible_rect().size

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:	
	label_hp.text = "%d" % round(GlobalStateMonitor.playerHP)
	if (GlobalStateMonitor.playerHP <= 0):
		label_death.visible = true
	else:
		label_death.visible = false
	
