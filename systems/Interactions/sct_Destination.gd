extends Area2D

var eggEntered : bool = false
var Egg : Eggy_Player


func _on_body_entered(body):
	if body is Eggy_Player:
		Egg = body
		Egg.move_to_holder(self.position)
		Egg.hold_character()
		eggEntered = true
		#body.hold_character()
		
func _physics_process(delta):
	pass
	#if eggEntered == true:
		#if Egg:
			#if Vector2i(self.position - Egg.position) != Vector2i(0,0):
				#Egg.move_to_holder(self.position)
			#else:
				#Egg.hold_character()
		#
