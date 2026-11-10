extends Node

#inform UI that update is needed
signal updateHelperUI

#how many helpers can be assigned
var maxHelpers:int = 3

#assigned helpers
var helpers:Array[int]=[1,2,0]
#0 - nobody
#1 - medic
#2 - dobermann
#3 - ace

#timer to reset helper availability
var helperTimers:Array[float]=[0.0,0.0,0.0]

#contains cooldowns for all helpers; filled in _ready; is not slot-related
var helperCooldowns:Array[float]=[]

#names for icos of current helpers
var helperIcons:Array[String]=["medic","dobermann","na"]

#sets helper in slot by id (see comment for helpers array variable)
func assignHelper(slotId:int, helperId:int, helperName:String) -> void:
	if (slotId >= 0 and slotId < maxHelpers):
		helpers[slotId] = helperId
		helperIcons[slotId] = helperName
		updateHelperUI.emit()
		
#sets helper timers to zero
func resetHelperTimers() -> void:
	for i in maxHelpers:
		helperTimers[i]=0.0
		
func useHelper(helperSlot:int) -> bool:
	if(helperTimers[helperSlot]<=0):
		
		if (helpers[helperSlot]==0): 
			return false
			
		if (helpers[helperSlot]==1): 			
			GlobalFuncLib.spawnSpeceffectAtPoint("res://scenes/se_helper_medic.tscn",GlobalStateMonitor.playerPos,Vector2(GlobalStateMonitor.playerDir,1.0))
			GlobalStateMonitor.healPlayer.emit(10)
			helperTimers[helperSlot] = helperCooldowns[helpers[helperSlot]]
			return true
			
		if (helpers[helperSlot]==2):
			GlobalFuncLib.spawnSpeceffectAtPoint("res://scenes/se_helper_dobermann.tscn",GlobalStateMonitor.playerPos,Vector2(GlobalStateMonitor.playerDir,1.0))
			GlobalFuncLib.spawnSpeceffectAtPoint("res://scenes/speceffect_dober_whip.tscn",GlobalStateMonitor.playerPos+Vector2(100,0)*GlobalStateMonitor.playerDir,Vector2(GlobalStateMonitor.playerDir,1.0))
			GlobalFuncLib.spawnSpeceffectAtPoint("res://scenes/helperScenes/dobermannAreaCast.tscn",GlobalStateMonitor.playerPos + Vector2(100,0)*GlobalStateMonitor.playerDir,Vector2(1.0,1.0))
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
