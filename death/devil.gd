extends Area2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

var parent: Node

func _ready() -> void:
	parent = get_parent()

func _process(delta: float) -> void:
	set_modulate(parent.boneco_color(parent.SelectedPlayerEnum.DEVIL))
	
	if Input.is_action_just_pressed("attack") && animation_player.current_animation == "RESET" && parent.selected_player == parent.SelectedPlayerEnum.DEVIL:
		animation_player.play("attack")
	
	position.x = get_parent().tandy_position.x + 160
	position.y = get_parent().tandy_position.y - 160


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	animation_player.play("RESET")
