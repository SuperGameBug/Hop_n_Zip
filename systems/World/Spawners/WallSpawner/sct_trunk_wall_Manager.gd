extends Node2D

class_name trunk_manager

var _tree_trunk_wall : PackedScene = preload("res://systems/World/Spawners/WallSpawner/obj_trunk_creator.tscn")
var _current_wall : trunk_creator
var _previous_wall : trunk_creator
var _exit_wall : trunk_creator
#var _first_spawn : bool = true

var _start_position : float = ProjectSettings.get_setting("display/window/size/viewport_width") - 16
var _initial_position : float  = ProjectSettings.get_setting("display/window/size/viewport_width") * 2
var _end_position : float = 32
#var _exit_position : float = -(ProjectSettings.get_setting("display/window/size/viewport_width"))
var _exit_position : float = 64

var _screen_height : float = ProjectSettings.get_setting("display/window/size/viewport_height")
var _parent_node : Node2D


func _ready():
	_parent_node = get_node("/root/World/Destroyables")
	_exit_position = 1-ProjectSettings.get_setting("display/window/size/viewport_width")
	
	_spawn_wall()


func _move_squence():
	if(!_previous_wall):
		_move_to_end()
	else:
		_move_to_exit(_exit_wall)
		_move_to_end()
		


func _spawn_wall():
	_current_wall = _tree_trunk_wall.instantiate(PackedScene.GEN_EDIT_STATE_INSTANCE)
	if(!_previous_wall):
		#print("trunk Manager: untrue")
		_current_wall.global_position = Vector2(_start_position,_screen_height)
	else:
		#print("trunk Manager: true")
		_current_wall.global_position = Vector2(_initial_position,_screen_height)
		_move_to_start()

	
	_current_wall._my_creator = self #creating a reference to self on the spawned wall
	
	_parent_node.add_child(_current_wall)
	
func _change_currentwall_to_previous():
	_previous_wall = _current_wall
	_current_wall = null
	
	_spawn_wall()
	
func _change_previouswall_to_exit():
	_exit_wall = _previous_wall
	_previous_wall = null
	
	_spawn_wall()

# following are the Tween Sequences 
func _move_to_start():
	_tween_to_position(_current_wall,Vector2(_start_position, _screen_height))
	print("trunkManager: moving to start")
	
	
func _move_to_end():

	_change_currentwall_to_previous()
	_tween_to_position(_previous_wall,Vector2(_end_position, _screen_height))
	
	print("trunkManager: moving to end")
	
func _move_to_exit(obj):
	_change_previouswall_to_exit()	
	_tween_to_position(_current_wall,Vector2(_exit_position, _screen_height),_destroy_wall, obj)
	_parent_node.remove_child(obj)



func _destroy_wall(obj):
	if(obj!=null):
		#obj.free()
		print("moving")
	

# actual tween method
func _tween_to_position(obj, goal_position, callback = null, value = null):
	if(obj):
		var move_tween = create_tween()
		move_tween.tween_property(obj,"global_position",goal_position,1.2).set_trans(Tween.TRANS_CUBIC).set_delay(.15)
		
		if(callback != null):
			move_tween.tween_callback(callback.bind(value))
	
