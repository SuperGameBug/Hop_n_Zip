extends Sprite2D

var _body_size : float = ProjectSettings.get_setting("display/window/size/viewport_width")
var _screen_bottom : float = ProjectSettings.get_setting("display/window/size/viewport_height")


# Called when the node enters the scene tree for the first time.
func _ready():
	self.global_position = Vector2(_body_size / 2.,_screen_bottom)
	#pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
