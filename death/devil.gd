extends Area2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var scythe_collision: CollisionPolygon2D = $Scythe/ScytheCollision

var parent: Node

func _ready() -> void:
	parent = get_parent()

func _process(delta: float) -> void:
	set_modulate(parent.boneco_color(parent.SelectedPlayerEnum.DEVIL))
	
	if Input.is_action_just_pressed("attack") && animation_player.current_animation == "RESET" && parent.selected_player == parent.SelectedPlayerEnum.DEVIL:
		scythe_collision.disabled = false
		animation_player.play("attack")
	
	position.x = get_parent().tandy_position.x + 160
	position.y = get_parent().tandy_position.y - 160

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	animation_player.play("RESET")
	scythe_collision.disabled = true

func _on_area_2d_2_body_entered(body: Node2D) -> void:
	print('SLASH!!!! ', body.name)
	
	if body is Soul:
		(body as Soul).soul_absorbed()
