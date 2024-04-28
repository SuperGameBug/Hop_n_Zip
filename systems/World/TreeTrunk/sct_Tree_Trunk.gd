extends Node2D

# Sprite variables
var _trunkSprite : Sprite2D
var _spriteMaterial : Material

# Called when the node enters the scene tree for the first time.
func _ready():
	_trunkSprite = $TrunkSprite
	_spriteMaterial = _trunkSprite.get_material()
	
	_spriteMaterial.set_shader_parameter("_frame", randi_range(0,1))
	_spriteMaterial.set_shader_parameter("_spriteLength", 2.)
	
	
