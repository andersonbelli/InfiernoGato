extends CharacterBody2D

class_name TandyClass

@export var bullet_scene: PackedScene

@onready var leg_2: Sprite2D = $Leg2
@onready var leg: Sprite2D = $Leg
@onready var arm_l: Sprite2D = $ArmL
@onready var arm_r: Sprite2D = $ArmR
@onready var body: Sprite2D = $Body
@onready var head: Sprite2D = $Head

@onready var marker: Marker2D = $ArmL/Marker2D
@onready var shot_light: Sprite2D = $ShotLight
@onready var timer: Timer = $Timer

var default_position: Vector2

var speed = 30.0
var jump_speed = -120.0
var is_jumping = false

var bullets = 6

var default_modulate
var parent: PlayerClass

func _ready() -> void:
	default_modulate = modulate
	parent = get_parent()

func _physics_process(delta):
	set_modulate(parent.boneco_color(parent.SelectedPlayerEnum.GIRL))
	
	parent.tandy_position = position
	
	arm_l.look_at(get_global_mouse_position())
	## Defines where the bullet should come from considering the arm/gun rotation
	shot_light.global_position = marker.global_position
	shot_light.rotation_degrees = arm_l.rotation_degrees
	
	if not timer.is_stopped():
		shot_light.visible = false
	
	if Input.is_action_just_pressed("attack") && parent.selected_player == parent.SelectedPlayerEnum.GIRL:
		if timer.is_stopped():
			timer.start()
			shot_light.visible = true
			shoot(get_global_mouse_position())
	
	# Add the gravity.
	velocity.y += 100 * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept"):
		if is_on_floor():
			velocity.y = jump_speed
			is_jumping = true
	else:
		if is_on_floor():
			is_jumping = false
		if not is_jumping:
			move_to_original_position()
		
	move_and_slide()

func shoot(mouse_position):
	var bullet = bullet_scene.instantiate() as RigidBody2D
	
	bullet.position = shot_light.position
	
	var direction = global_position.direction_to(mouse_position)
	var impulse = direction * 2600
	bullet.apply_central_impulse(impulse)
	
	add_child(bullet)
	
func move_to_original_position():
	if is_on_floor():
		if default_position == Vector2.ZERO:
			default_position = position
		
		if (default_position != Vector2.ZERO && round_to_dec(default_position.y, 1) != round_to_dec(position.y, 1)):
			var tween = create_tween()
			tween.tween_property(self, "position", default_position, 1)
			await tween.finished
			tween.kill()

func round_to_dec(num, digit):
	return round(num * pow(10.0, digit)) / pow(10.0, digit)


func _on_timer_timeout() -> void:
	shot_light.visible = false
	timer.stop()
