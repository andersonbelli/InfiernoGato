extends Node2D

enum SelectedPlayerEnum { GIRL, DEVIL }

var select
var tandy_position: Vector2

var selected_player: SelectedPlayerEnum

func _ready() -> void:
	selected_player = SelectedPlayerEnum.GIRL


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("change_character"):
		if selected_player == SelectedPlayerEnum.GIRL:
			selected_player = SelectedPlayerEnum.DEVIL
		else:
			selected_player = SelectedPlayerEnum.GIRL
