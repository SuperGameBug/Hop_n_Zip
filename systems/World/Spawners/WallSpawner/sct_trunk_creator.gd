extends Node2D

class_name trunk_creator



var _my_creator : trunk_manager
var _trunk_wall: PackedScene = preload("res://systems/World/TreeTrunk/obj_Tree_Trunk.tscn")
var _nest_platform: PackedScene = preload("res://systems/Interactions/platform/obj_nest_Platform.tscn")
var _initialpoint: Vector2 = Vector2(0,0)
const _numberOfTrunks: int = 11

# Called when the node enters the scene tree for the first time.
func _ready():
	var randomEmptyBlock = randi_range(2,_numberOfTrunks - 2)
	for i in _numberOfTrunks:
		if randomEmptyBlock != i and (randomEmptyBlock + 1) != i:
			spawn_trunks(i)
		elif i == (randomEmptyBlock + 1):
			pass
			
		else:
			spawn_nest(i)
	


func spawn_trunks(i):
	var trunk = _trunk_wall.instantiate()
	trunk.position = _initialpoint - Vector2(0., i * 32)
	add_child(trunk)

func spawn_nest(i):
	var nest = _nest_platform.instantiate()
	nest.position = _initialpoint - Vector2(0., i * 32)
	nest._mySpawner = self
	add_child(nest)


func _safely_landed():		#calls functions that sequences the tweening of tree trunks
	if(_my_creator):
		_my_creator._move_squence()
		print("Creator: Move")
		#_my_creator._spawn_wall()
