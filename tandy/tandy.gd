extends CharacterBody2D

@onready var leg_2: Sprite2D = $Leg2
@onready var leg: Sprite2D = $Leg
@onready var arm_l: Sprite2D = $ArmL
@onready var arm_r: Sprite2D = $ArmR
@onready var body: Sprite2D = $Body
@onready var head: Sprite2D = $Head

var speed = 30.0
var jump_speed = -120.0

var bullets = 6

var parent: Node

func _ready() -> void:
	parent = get_parent()

func _physics_process(delta):
	if parent.selected_player == parent.SelectedPlayerEnum.GIRL && Input.is_action_just_pressed("attack"):
		print('shot!')
	
	arm_l.look_at(get_global_mouse_position())
	
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
