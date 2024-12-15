extends CharacterBody2D

@onready var leg_2: Sprite2D = $Leg2
@onready var leg: Sprite2D = $Leg
@onready var arm_l: Sprite2D = $ArmL
@onready var arm_r: Sprite2D = $ArmR
@onready var body: Sprite2D = $Body
@onready var head: Sprite2D = $Head

var arm_l_start_position
var arm_r_start_position

var speed = 300.0
var jump_speed = -120.0

func _ready() -> void:
	arm_r_start_position = arm_r.position.x
	arm_l_start_position = arm_l.position.x

func _physics_process(delta):
	get_parent().tandy_position = position
	
	# Add the gravity.
	velocity.y += 100 * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_speed

	var direction = Input.get_axis("ui_left", "ui_right")
	
	if ((direction == -1 || direction == 1) && get_parent().tandy_direction != direction):
		get_parent().tandy_direction = direction
		
		if (direction == -1):
			flip_assets(true)
		elif (direction == 1):
			flip_assets(false)
	
	velocity.x = direction * speed

	move_and_slide()


func flip_assets(should_flip: bool):
	leg.flip_h = should_flip
	leg_2.flip_h = should_flip
	arm_r.flip_h = should_flip
	arm_l.flip_h = should_flip
	head.flip_h = should_flip
	body.flip_h = should_flip
	
	if (should_flip):
		arm_l.position.x = arm_l_start_position - 60
		arm_r.position.x = arm_r_start_position - 90
	else:
		arm_l.position.x = arm_l_start_position
		arm_r.position.x = arm_r_start_position
