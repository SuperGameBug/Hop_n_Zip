extends Node2D

class_name Tree_Trunk

# Sprite variables
var _trunkSprite : Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	_trunkSprite = $TrunkSprite
	_trunkSprite.frame = randi_range(0,1)
	_trunkSprite.flip_v = randi_range(0,1)
