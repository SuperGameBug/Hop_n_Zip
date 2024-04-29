extends RigidBody2D
class_name Eggy_Player

signal on_mouse_Drag_start
signal on_mouse_Drag_end


const maximum_jump_force = 1000.



var _init_mouse_position : Vector2
var _end_mouse_position : Vector2
var bDebug : bool = false
var playersprite : Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	playersprite = $Sprite2D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _input(event):
	pass
	
func _physics_process(delta):

	if(!self.freeze):
		sprite_anim_Rotate()
	

	if Input.is_action_just_pressed("debug_switch"):
		if bDebug != true:
			bDebug = true
		else :
			bDebug = false
		print(bDebug)
		
	
		
	
	
		
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().reload_current_scene()
	
	if (self.freeze == true):
		if Input.is_action_just_pressed("touch_primary"):			# Stores initial Mouse position
			_init_mouse_position = get_global_mouse_position()
			on_mouse_Drag_start.emit()
			
			
		if Input.is_action_just_released("touch_primary"):			# Subtracts initial mouse position with released position
		
			self.set_deferred("freeze", false)
			on_mouse_Drag_end.emit()
			
			
			_end_mouse_position = get_global_mouse_position()
			
			var impulse_direction = (_init_mouse_position - _end_mouse_position).normalized()
			var jump_mag = clamp((_init_mouse_position - _end_mouse_position).length() * 5.,-maximum_jump_force,maximum_jump_force)

			
			print(jump_mag)
			
			
			self.linear_velocity = (impulse_direction * jump_mag)


		
		
func hold_character():
	self.set_deferred("freeze", true)
	
func move_to_holder(new_position):
	
	var moveTween = create_tween()
	var rotTween = create_tween()
	
	moveTween.tween_property(self, "position",new_position,.1)
	rotTween.tween_property(self, "rotation_degrees",0,.1)
	
func sprite_anim_Rotate():
		var spriteRotation = int(fposmod(self.rotation + 0.2,2.* PI) * 1.27388535032)
		playersprite.frame = spriteRotation
	

	
