extends CharacterBody2D

@export var bullet_scene: PackedScene

@onready var leg_2: Sprite2D = $Leg2
@onready var leg: Sprite2D = $Leg
@onready var arm_l: Sprite2D = $ArmL
@onready var arm_r: Sprite2D = $ArmR
@onready var body: Sprite2D = $Body
@onready var head: Sprite2D = $Head

@onready var marker: Marker2D = $ArmL/Marker2D

var speed = 30.0
var jump_speed = -120.0

var bullets = 6

var default_modulate
var parent: Node

func _ready() -> void:
	default_modulate = modulate
	parent = get_parent()

func _physics_process(delta):
	set_modulate(parent.boneco_color(parent.SelectedPlayerEnum.GIRL))
	
	if Input.is_action_just_pressed("attack") && parent.selected_player == parent.SelectedPlayerEnum.GIRL:
		shoot(get_global_mouse_position())
	
	arm_l.look_at(get_global_mouse_position())
	## TODO: Marker should follow point of the GUN
	
	parent.tandy_position = position
	
	# Add the gravity.
	velocity.y += 100 * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_speed
	
	if is_on_floor():
		#velocity.x += speed * delta
		pass
		
	move_and_slide()

func shoot(mouse_position):
	var bullet = bullet_scene.instantiate() as RigidBody2D
	
	bullet.position = marker.position
	bullet.rotation_degrees = global_rotation
	
	var direction = global_position.direction_to(mouse_position)
	var impulse = direction * 1600
	bullet.apply_central_impulse(impulse)
	
	add_child(bullet)
	
