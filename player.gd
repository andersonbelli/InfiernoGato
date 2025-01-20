extends Node2D

class_name PlayerClass

enum SelectedPlayerEnum { GIRL, DEVIL }

var select
var tandy_position: Vector2

var selected_player: SelectedPlayerEnum

func _ready() -> void:
	selected_player = SelectedPlayerEnum.GIRL


func _process(delta: float) -> void:
	Globals.player_position = tandy_position
	
	if Input.is_action_just_pressed("change_character"):
		change_boneco()

func change_boneco():
	if selected_player == SelectedPlayerEnum.GIRL:
		selected_player = SelectedPlayerEnum.DEVIL
	else:
		selected_player = SelectedPlayerEnum.GIRL

func boneco_color(self_boneco: SelectedPlayerEnum) -> Color:
	if selected_player != self_boneco:
		return Color("7e7e7e")
	else:
		return Color("FFFFFF")
