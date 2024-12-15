extends Area2D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if (get_parent().tandy_direction == -1):
		position.x = get_parent().tandy_position.x - 160
	else:
		position.x = get_parent().tandy_position.x + 160
