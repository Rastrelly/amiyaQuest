extends Node2D

var page:int = 0
var opsPerPage:int = 8
var startIndex:int = 1
var slot:int = 0

var selOpInd:int = -1

var opTex:Array[Texture2D]

func getHelperName(id:int)-> String:
	var l:int = GlobalHelperController.helperNames.size()
	if (id < l):
		return GlobalHelperController.helperNames[id]
	else:
		return "na"

#prepPageTextures
func prepPageTextures() ->void:
	opTex.clear()
	for i in 8:
		opTex.append(load("res://sprites/uiGraphics/ico_"+getHelperName(i+startIndex+opsPerPage*page)+"_smol.png"))

func assignPageTextures() ->void:
	$Camera2D/Control/GridContainer/opImg1.texture_normal = opTex[0]
	$Camera2D/Control/GridContainer/opImg2.texture_normal = opTex[1]
	$Camera2D/Control/GridContainer/opImg3.texture_normal = opTex[2]
	$Camera2D/Control/GridContainer/opImg4.texture_normal = opTex[3]
	$Camera2D/Control/GridContainer/opImg5.texture_normal = opTex[4]
	$Camera2D/Control/GridContainer/opImg6.texture_normal = opTex[5]
	$Camera2D/Control/GridContainer/opImg7.texture_normal = opTex[6]
	$Camera2D/Control/GridContainer/opImg8.texture_normal = opTex[7]
	$Camera2D/Control/GridContainer/opImg1.texture_hover = opTex[0]
	$Camera2D/Control/GridContainer/opImg2.texture_hover = opTex[1]
	$Camera2D/Control/GridContainer/opImg3.texture_hover = opTex[2]
	$Camera2D/Control/GridContainer/opImg4.texture_hover = opTex[3]
	$Camera2D/Control/GridContainer/opImg5.texture_hover = opTex[4]
	$Camera2D/Control/GridContainer/opImg6.texture_hover = opTex[5]
	$Camera2D/Control/GridContainer/opImg7.texture_hover = opTex[6]
	$Camera2D/Control/GridContainer/opImg8.texture_hover = opTex[7]
	$Camera2D/Control/GridContainer/opImg1.texture_pressed = opTex[0]
	$Camera2D/Control/GridContainer/opImg2.texture_pressed = opTex[1]
	$Camera2D/Control/GridContainer/opImg3.texture_pressed = opTex[2]
	$Camera2D/Control/GridContainer/opImg4.texture_pressed = opTex[3]
	$Camera2D/Control/GridContainer/opImg5.texture_pressed = opTex[4]
	$Camera2D/Control/GridContainer/opImg6.texture_pressed = opTex[5]
	$Camera2D/Control/GridContainer/opImg7.texture_pressed = opTex[6]
	$Camera2D/Control/GridContainer/opImg8.texture_pressed = opTex[7]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	prepPageTextures()
	assignPageTextures()
	updateSelOps()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_btn_start_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main.tscn")


func _on_btn_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/mainMenu.tscn")


func _on_btn_prev_pressed() -> void:
	page-=1
	if (page<0): page=0
	prepPageTextures()
	assignPageTextures()

func _on_btn_next_pressed() -> void:
	page+=1
	prepPageTextures()
	assignPageTextures()
	
func updateSelOps()->void:
	$Camera2D/Control/selOP1.set_texture(load("res://sprites/uiGraphics/ico_"+GlobalHelperController.helperIcons[0]+"_big.png"))
	$Camera2D/Control/selOP2.set_texture(load("res://sprites/uiGraphics/ico_"+GlobalHelperController.helperIcons[1]+"_big.png"))
	$Camera2D/Control/selOP3.set_texture(load("res://sprites/uiGraphics/ico_"+GlobalHelperController.helperIcons[2]+"_big.png"))

func setOp(id:int)->void:
	var butInd:int = id
	var sOpInd:int = butInd+1 + opsPerPage*page
	selOpInd =  sOpInd
	GlobalHelperController.assignHelper(slot,sOpInd,getHelperName(sOpInd))
	updateSelOps()

func _on_btn_sel_1_pressed() -> void:
	slot = 0


func _on_btn_sel_2_pressed() -> void:
	slot = 1


func _on_btn_sel_3_pressed() -> void:
	slot = 2

func _on_op_img_1_pressed() -> void:
	setOp(0)

func _on_op_img_2_pressed() -> void:
	setOp(1)


func _on_op_img_3_pressed() -> void:
	setOp(2)


func _on_op_img_4_pressed() -> void:
	setOp(3)


func _on_op_img_5_pressed() -> void:
	setOp(4)


func _on_op_img_6_pressed() -> void:
	setOp(5)


func _on_op_img_7_pressed() -> void:
	setOp(6)


func _on_op_img_8_pressed() -> void:
	setOp(7)
