extends Node2D

func _ready():
	get_viewport().size = Vector2i(1280,720)
	
	
func _on_btn_quit_pressed():
	Utils.saveGame()
	get_tree().quit()


func _on_btn_play_pressed():
	get_tree().change_scene_to_file("res://levels/lvl_world.tscn")
