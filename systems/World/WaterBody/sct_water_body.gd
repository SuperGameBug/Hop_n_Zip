extends Sprite2D

var _body_size : float = ProjectSettings.get_setting("display/window/size/viewport_width")
var _screen_bottom : float = ProjectSettings.get_setting("display/window/size/viewport_height")

var _egg : Eggy_Player
var _watermaterial : Material
var _ripple_intensity : float = 0
var _make_ripple : bool = false


# Called when the node enters the scene tree for the first time.
func _ready():
	_make_ripple = false
	self.global_position = Vector2(_body_size / 2.,_screen_bottom)
	_watermaterial = self.material
	_watermaterial.set_shader_parameter("_waterWidth", _body_size)
	
	print(_body_size/4.)
	
	#pass
	
func _process(delta):
	if(_make_ripple == true):
		#pass
		_watermaterial.set_shader_parameter("_ripple_intensity", lerpf(0.,1.,_ripple_intensity))
		print(_ripple_intensity)





func _on_area_2d_body_entered(body):
	if(body is Eggy_Player):
		var dropPos = body.global_position/ _body_size
		#print("Water: " + str(dropPos))
		_start_ripple();
		tween_ripple_start()
		
		
		_watermaterial.set_shader_parameter("_dropPosition", dropPos.x)
		#tween_ripple(1., 2., _start_ripple, false)
		



func _start_ripple():
	_make_ripple = true
	_watermaterial.set_shader_parameter("_startDrop", _make_ripple)

func _end_ripple():
	_make_ripple = false
	_watermaterial.set_shader_parameter("_startDrop", _make_ripple)

	
func tween_ripple_start():
	tween_ripple(1.,.2, tween_ripple_end)
	
	
func tween_ripple_end():
	tween_ripple(0., 2., _end_ripple)

	
func tween_ripple(goal, length, callback = null):
	
	var ripple_tween = create_tween()
	ripple_tween.tween_property(self, "_ripple_intensity", goal,length)
	if(callback):
		ripple_tween.tween_callback(callback)
	


