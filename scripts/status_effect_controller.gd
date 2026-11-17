#handles stack of status effects on attached-to actor
class_name statEffController extends Node

var effectStates:Array[float]

#effect 0 - shield
#effect 1 - stagger

#adds effect to stack
func addEffect(id:int, time:float)->void:
	if (not id < effectStates.size()):
		effectStates.resize(id+1)
	effectStates[id] = time

#returns effect timer
func getEffectTime(id:int)->float:
	if (not id < effectStates.size()): return 0.0
	else:
		return effectStates[id]

#returns if effect is even there
func hasEffect(id:int)->bool:
	if (getEffectTime(id) > 0.0): return true
	else: return false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if effectStates.size()>0:
		for i in effectStates.size():
			effectStates[i]-=delta
			if (effectStates[i] < 0): effectStates[i] = 0.0
		
