extends Label
#@export var Player : Eggy_Player

func _physics_process(delta):
	self.text = str(Engine.get_frames_per_second())
