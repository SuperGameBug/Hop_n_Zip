extends Node2D

class_name platform_spawner

var TrunkWall: PackedScene = preload("res://systems/World/TreeTrunk/obj_Tree_Trunk.tscn")
var NestPlatform: PackedScene = preload("res://systems/Interactions/obj_nest_Platform.tscn")
var initialpoint: Vector2 = Vector2(0,0)
const numberOfTrunks: int = 11

# Called when the node enters the scene tree for the first time.
func _ready():
	var randomEmptyBlock = randi_range(2,numberOfTrunks - 2)
	print(randomEmptyBlock)
	for i in numberOfTrunks:
		if randomEmptyBlock != i and (randomEmptyBlock + 1) != i:
			var trunk = TrunkWall.instantiate()
			trunk.position = initialpoint - Vector2(0., i * 32)
			add_child(trunk)
		elif i == (randomEmptyBlock + 1):
			pass
			
		else:
			var nest = NestPlatform.instantiate()
			nest.position = initialpoint - Vector2(0., i * 32)
			nest.mySpawner = self
			add_child(nest)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _safely_landed():
	print("Landed Safely")
