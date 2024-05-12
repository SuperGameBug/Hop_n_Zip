extends Area2D

var _eggEntered : bool = false
var _egg : Eggy_Player
var _exitCount : int = 0
#var _eggEnteredOnce : bool = false

var _mySpawner : trunk_creator
var _nestCollision : CollisionShape2D

func _ready():
	_nestCollision = $CollisionShape2D


func _on_body_entered(body):
	#print(get_parent())
	if body is Eggy_Player and _eggEntered == false:
		_egg = body
		_egg.move_to_holder(self.global_position)
		_egg.hold_character()
		_eggEntered = true
		

		
		if(_mySpawner):
			_egg.reparent(self)
			move_child(_egg,0)
			
			# execing event on spawner to do tasks after safely landing
			_mySpawner._safely_landed()
			

			print("nest: I've Landed")
		
		


func _on_body_exited(body):
	
	print("Nest: " + str(body))
	
	if(body == _egg and _egg._is_launched == true):
		# removing collision after egg is attached: 
		# this fixes a bug where sometimes the egg might snap back to the nest after launch
		_nestCollision.set_deferred("disabled", true)
		
		print(str(get_parent()) +  "Nest : Collision killed")
		_egg.reparent(_egg._eggyDefaultParent)
		_egg.set_deferred("reparent", _egg._eggyDefaultParent)
		_egg = null
		
		if(!_mySpawner):
			_tween_and_exit()
		else:
			_exitCount += 1
			print("nest: I've Exited" + str(_exitCount))
			
func _destroy():
	self.queue_free()
		
		
func _tween_and_exit():
	var scale_tween = create_tween()
	scale_tween.tween_property(self,"scale", Vector2(0.,0.),.5).set_trans(Tween.TRANS_BACK)
	scale_tween.tween_callback(_destroy)
