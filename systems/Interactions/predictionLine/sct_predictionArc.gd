extends Node2D
class_name predictionArc

@export var Player : Eggy_Player

var _gravity : float = ProjectSettings.get_setting("physics/2d/default_gravity")
var _isDragging : bool = false
var _bubbleSprite = []
const _predictor_amount : int = 16
var _parent_node : Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	_parent_node = get_node("/root/World/Destroyables")
	for i in _predictor_amount:
		var childSprite = Sprite2D.new()
		childSprite.texture = load("res://sprites/world/spr_Bubble.png")
		_bubbleSprite.append(childSprite)
		#childSprite.tree
		
	
func _predict_arc(delta):

	var current_mouse_location = get_global_mouse_position()
	var drag_direction = (Player._init_mouse_position - current_mouse_location).normalized()
	var drag_distance = (Player._init_mouse_position - current_mouse_location).length()
	
	for i in _bubbleSprite.size():
				
		# Spawining Bubbles
		if _bubbleSprite[i].is_inside_tree() == false:
			_parent_node.add_child(_bubbleSprite[i])
		
		var UpVector = Vector2(0.,1.).rotated(Player.rotation)
			
		_bubbleSprite[i].position = Player.global_position - (16.*UpVector)
		

		var timeelapsed = pow(float(i)/float(_bubbleSprite.size()),2.)
		
		_bubbleSprite[i].position.x += ((drag_direction.x * drag_distance) * timeelapsed)
		_bubbleSprite[i].position.y += ((drag_direction.y * drag_distance) * timeelapsed)
		
		_bubbleSprite[i].position.y += (pow(_gravity * 2. * timeelapsed,2.) / 100000.) * timeelapsed

		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if(_isDragging == true):
		_predict_arc(delta)
		
	
	

func _on_eggy_player_on_mouse_drag_start():
	_isDragging = true



func _on_eggy_player_on_mouse_drag_end():
	_isDragging = false
	for i in _bubbleSprite.size():
		_parent_node.remove_child(_bubbleSprite[i])
