extends Area2D

var _eggEntered : bool = false
var _egg : Eggy_Player

var _mySpawner : trunk_creator

func _ready():
	pass


func _on_body_entered(body):
	if body is Eggy_Player:
		_egg = body
		_egg.move_to_holder(self.global_position)
		_egg.hold_character()
		_eggEntered = true
		
		if(_mySpawner):
			_egg.reparent(self)
			move_child(_egg,0)
			_mySpawner._safely_landed()
			print(_egg.get_parent())
		
		


func _on_body_exited(body):
	if(_egg):
		_egg.reparent(get_node("root/World/PlayGroup"))
		_egg = null
		if(!_mySpawner):
			self.queue_free()
		
