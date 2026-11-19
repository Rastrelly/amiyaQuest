extends TextureRect

var sec:Node = null

func getPlrSec()->void:
	sec = GlobalStateMonitor.plrRef.get_node("statEffController")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	getPlrSec()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (sec == null): 
		getPlrSec()
		visible = false
	else:
		if (sec.getEffectTime(0)>0):
			visible = true
		else:
			visible = false
