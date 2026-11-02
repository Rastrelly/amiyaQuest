extends Node2D

@onready var main_menu_node: Node2D = $"."


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_btn_new_game_button_up() -> void:
	get_tree().change_scene_to_file("res://scenes/main.tscn")


#quit request as in: https://docs.godotengine.org/en/stable/tutorials/inputs/handling_quit_requests.html
func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		get_tree().quit() # default behavior	

func _on_button_button_up() -> void:
	get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
