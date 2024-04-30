extends Area2D

var eggEntered : bool = false
var Egg : Eggy_Player

var mySpawner : platform_spawner

func _ready():
	pass


func _on_body_entered(body):
	if body is Eggy_Player:
		Egg = body
		Egg.move_to_holder(self.global_position)
		Egg.hold_character()
		eggEntered = true
		#body.hold_character()
		if(mySpawner):
			mySpawner._safely_landed()
		
		


func _on_body_exited(body):
	if(Egg):
		Egg = null
		
