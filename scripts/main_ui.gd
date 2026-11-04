extends Control

@onready var ui_cont: AspectRatioContainer = $uiCont
@onready var label_hp: Label = $uiCont/labelHP
@onready var label_death: Label = $uiCont/labelDeath

var scrSize:Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	scrSize = get_viewport().get_visible_rect().size
	ui_cont.custom_minimum_size = scrSize
	ui_cont.custom_maximum_size = scrSize

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:	
	label_hp.text = "%d" % round(GlobalStateMonitor.playerHP)
	if (GlobalStateMonitor.playerHP <= 0):
		label_death.visible = true
	else:
		label_death.visible = false
	
