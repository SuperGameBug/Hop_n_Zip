extends Node2D

class_name trunk_manager

var _tree_trunk_wall : PackedScene = preload("res://systems/World/Spawners/WallSpawner/obj_trunk_creator.tscn")
var _current_wall : trunk_creator
var _previous_wall : trunk_creator
#var _first_spawn : bool = true

var _start_position : float = ProjectSettings.get_setting("display/window/size/viewport_width") - 16
var _initial_position : float  = ProjectSettings.get_setting("display/window/size/viewport_width") * 2
var _end_position : float = 32
var _exit_position : float = -(ProjectSettings.get_setting("display/window/size/viewport_width"))


var _screen_height : float = ProjectSettings.get_setting("display/window/size/viewport_height")
var _parent_node : Node2D


func _ready():
	_parent_node = get_node("/root/World/Destroyables")
	_exit_position = 1-ProjectSettings.get_setting("display/window/size/viewport_width")
	
	_spawn_wall()



func _process(delta):
	pass
	#if(Input.is_action_pressed("touch_secondary")):
		#_move_to_start()
		


func _spawn_wall():
	_current_wall = _tree_trunk_wall.instantiate()
	if(!_previous_wall):
		print("untrue")
		_current_wall.global_position = Vector2(_start_position,_screen_height)
	else:
		print("true")		
		_current_wall.global_position = Vector2(_initial_position,_screen_height)
		_move_to_start()
	
	_current_wall._my_creator = self #creating a reference to self on the spawned wall
	
	_parent_node.add_child(_current_wall)
	
func _change_current_wall_to_previous():
	_previous_wall = _current_wall
	print("quest pasa")
	_spawn_wall()
	
func _move_to_start():
	_tween_to_position(_current_wall,Vector2(_start_position, _screen_height))
	
func _move_to_end():
	_tween_to_position(_current_wall,Vector2(_end_position, _screen_height))
	
func _move_to_exit(obj):
	_tween_to_position(_current_wall,Vector2(_exit_position, _screen_height),_destroy_wall, obj)
	_parent_node.remove_child(obj)
	
func _destroy_wall(obj):
	if(obj!=null):
		obj.free()
	
	
func _tween_to_position(obj, goal_position, callback = null, value = null):
	var move_tween = create_tween()
	move_tween.tween_property(obj,"global_position",goal_position,1.2).set_trans(Tween.TRANS_BACK).set_delay(.3)
	
	if(callback != null):
		move_tween.tween_callback(callback.bind(value))
	
