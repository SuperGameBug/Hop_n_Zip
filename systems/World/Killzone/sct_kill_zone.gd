extends Area2D

class_name KillZone2D

var _egg : Eggy_Player



func _on_body_entered(body):
	
	if body is Eggy_Player:
		_egg = body
		get_tree().change_scene_to_file("res://levels/lvl_world.tscn")
