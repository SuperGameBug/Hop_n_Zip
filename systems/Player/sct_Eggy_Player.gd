extends RigidBody2D
class_name Eggy_Player

signal on_mouse_Drag_start
signal on_mouse_Drag_end


const _maximum_jump_force = 1000.
const _devmode : bool = false



var _init_mouse_position : Vector2
var _end_mouse_position : Vector2
var _playersprite : Sprite2D
var _is_aiming : bool = false
var _is_launched : bool = false
var _Collider2d : CollisionShape2D
var _eggyDefaultParent : Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	_eggyDefaultParent = self.get_parent()
	_playersprite = $Sprite2D
	_Collider2d = $CollisionShape2D


	
func _physics_process(delta):

	if(!self.freeze):
		sprite_anim_Rotate()
	

		
	if(Input.is_action_just_pressed("touch_secondary")):
		pass
	
		
	
	
		
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().reload_current_scene()
	
	#if (self.freeze == true):
	if (self.freeze == true):	
		if Input.is_action_just_pressed("touch_primary"):			# Stores initial Mouse position
			_init_mouse_position = get_global_mouse_position()
			on_mouse_Drag_start.emit()
			_is_aiming = true                      # makes sure egg only leaps after aiming is done
			
			
		if (Input.is_action_just_released("touch_primary") and _is_aiming == true):			# Subtracts initial mouse position with released position
			
			_is_aiming = false
		
			self.set_deferred("freeze", false)
			_Collider2d.set_deferred("disabled", false)
			
			on_mouse_Drag_end.emit()
			
			
			_end_mouse_position = get_global_mouse_position()
			
			var impulse_direction = (_init_mouse_position - _end_mouse_position).normalized()
			var jump_mag = clamp((_init_mouse_position - _end_mouse_position).length() * 5.,-_maximum_jump_force,_maximum_jump_force)
			
			_is_launched = true

			
			
			
			self.linear_velocity = (impulse_direction * jump_mag)


		
		
func hold_character():
	self.set_deferred("freeze", true)
	_Collider2d.set_deferred("disabled", true)
	
func move_to_holder(new_position):
	
	var moveTween = create_tween()
	#var rotTween = create_tween()
	settled_egg()
	moveTween.tween_property(self, "global_position",new_position,.1)
	moveTween.parallel().tween_property(self, "rotation_degrees",0,.1)
	

	
func sprite_anim_Rotate():
		var spriteRotation = int(fposmod(self.rotation + 0.2,2.* PI) * 1.27388535032)
		_playersprite.frame = spriteRotation
		
		
func settled_egg():
	_is_launched = false
	print("Eggy: _is_launched = " + str(_is_launched))
	

	
