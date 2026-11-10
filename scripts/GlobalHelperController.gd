extends Node

#how many helpers can be assigned
var maxHelpers:int = 3

#assigned helpers
var helpers:Array[int]=[0,2,0]
#0 - nobody
#1 - medic
#2 - dobermann
#3 - ace

#contains cooldowns for all helpers; filled in _ready; is not slot-related
var helperCooldowns:Array[float]=[]

var helperTimers:Array[float]=[0.0,0.0,0.0]


#sets helper in slot by id (see comment for helpers array variable)
func assignHelper(slotId:int, helperId:int) -> void:
	if (slotId >= 0 and slotId < maxHelpers):
		helpers[slotId] = helperId
		
func resetHelperTimers() -> void:
	#run timers
	for i in maxHelpers:
		helperTimers[i]=0.0
		
func useHelper(helperSlot:int) -> bool:
	if(helperTimers[helperSlot]<=0):
		if (helpers[helperSlot]==0): 
			return false
		if (helpers[helperSlot]==1): 
			return true
		if (helpers[helperSlot]==2):
			var helperSe = load("res://scenes/se_helper_dobermann.tscn")
			var helperSeInst = helperSe.instantiate()
			get_tree().current_scene.add_child(helperSeInst)
			helperSeInst.position = GlobalStateMonitor.playerPos
			helperTimers[helperSlot] = helperCooldowns[helpers[helperSlot]]
			return true
		if (helpers[helperSlot]==3): 
			return true
	return false
		

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	helperCooldowns.append(0)
	helperCooldowns.append(45.0) #medic
	helperCooldowns.append(15.0) #dobermann
	helperCooldowns.append(5.0)  #ace


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#run timers
	for i in maxHelpers:
		helperTimers[i]-=delta
		if (helperTimers[i]<0):
			helperTimers[i]=0.0
