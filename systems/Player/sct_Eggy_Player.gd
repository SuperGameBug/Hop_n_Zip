extends RigidBody2D
class_name Eggy_Player


const maximum_jump_force = 2500
#const minClamp = Vector2(-impulseClamp,-impulseClamp)
#const maxClamp = Vector2(impulseClamp,impulseClamp)


var _init_mouse_position : Vector2
var _end_mouse_position : Vector2
var bDebug : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if Input.is_action_just_pressed("debug_switch"):
		if bDebug != true:
			bDebug = true
		else :
			bDebug = false
		print(bDebug)
		
		
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().reload_current_scene()
	
	if Input.is_action_just_pressed("touch_primary"):			# Stores initial Mouse position
		_init_mouse_position = get_global_mouse_position()
		
		
	if Input.is_action_just_released("touch_primary"):			# Subtracts initial mouse position with released position
		self.set_deferred("freeze", false)
		
		
		_end_mouse_position = get_global_mouse_position()
		
		var eggy_impulse = (_init_mouse_position - _end_mouse_position)*20.
		
		# Clamping both axes separately
		eggy_impulse.x = clamp(eggy_impulse.x, -maximum_jump_force, maximum_jump_force)
		eggy_impulse.y = clamp(eggy_impulse.y, -maximum_jump_force, maximum_jump_force)
		apply_central_force(eggy_impulse)
		

		
		
func hold_character():
	self.set_deferred("freeze", true)
	
func move_to_holder(new_position):
	#var required_velocity = new_position - self.position
	#
	#print(required_velocity)
	#self.linear_velocity = (required_velocity)
	#
	
	#self.linear_velocity = Vector2(0.,0.)
	
	var moveTween = create_tween()
	var rotTween = create_tween()
	
	moveTween.tween_property(self, "position",new_position,.1)
	rotTween.tween_property(self, "rotation_degrees",0,.1)
	
	#rotTween.tween_callback(testFunc())
