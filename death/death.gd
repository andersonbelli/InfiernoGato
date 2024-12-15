extends Area2D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	position.x = get_parent().tandy_position.x + 160
