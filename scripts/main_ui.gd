extends Control

@onready var ui_cont: AspectRatioContainer = $uiCont
@onready var label_hp: Label = $labelHP
@onready var label_death: Label = $labelDeath

@onready var hlp1ico: TextureRect = $HBoxContainer/helper1
@onready var hlp2ico: TextureRect = $HBoxContainer/helper2
@onready var hlp3ico: TextureRect = $HBoxContainer/helper3


@onready var hlp1pb: ProgressBar = $HBoxContainer2/pb_helper1_reload
@onready var hlp2pb: ProgressBar = $HBoxContainer2/pb_helper2_reload
@onready var hlp3pb: ProgressBar = $HBoxContainer2/pb_helper3_reload


var scrSize:Vector2

#refresh UI icons
func updateUIElems() -> void:
	hlp1ico.set_texture(load("res://sprites/uiGraphics/ico_"+GlobalHelperController.helperIcons[0]+"_smol.png"))
	hlp2ico.set_texture(load("res://sprites/uiGraphics/ico_"+GlobalHelperController.helperIcons[1]+"_smol.png"))
	hlp3ico.set_texture(load("res://sprites/uiGraphics/ico_"+GlobalHelperController.helperIcons[2]+"_smol.png"))

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	scrSize = get_viewport().get_visible_rect().size
	GlobalHelperController.updateHelperUI.connect(updateUIElems)
	updateUIElems()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:	
	label_hp.text = "%d" % round(GlobalStateMonitor.playerHP)
	if (GlobalStateMonitor.playerHP <= 0):
		label_death.visible = true
	else:
		label_death.visible = false
	
	#set progresbar maximums
	hlp1pb.max_value = GlobalHelperController.helperCooldowns[GlobalHelperController.helpers[0]]
	hlp2pb.max_value = GlobalHelperController.helperCooldowns[GlobalHelperController.helpers[1]]
	hlp3pb.max_value = GlobalHelperController.helperCooldowns[GlobalHelperController.helpers[2]]
	
	#update progress
	hlp1pb.value = GlobalHelperController.helperTimers[0]
	hlp2pb.value = GlobalHelperController.helperTimers[1]
	hlp3pb.value = GlobalHelperController.helperTimers[2]
