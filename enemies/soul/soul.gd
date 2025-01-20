extends RigidBody2D

class_name Soul

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var timer = $Timer
@onready var soul: Sprite2D = $Soul

var floating = false

var shard_value = 1

func _process(delta):
	if timer.time_left < 2:
		animation_player.play("timer_running_out")

func _physics_process(delta: float) -> void:
	position -= Globals.player_position.direction_to(position) * 3
	self.apply_impulse(Vector2(0, randi_range(-25, -55)))
	
	chase_player(Globals.player_position)

func chase_player(_player: Vector2):
	if (position.x <= Globals.player_position.x + 350):
		linear_velocity = Vector2.ZERO
		self.apply_impulse(Vector2(3050, 55))
	else:
		if (position.y >= randi_range(185, 485)):
			linear_velocity = Vector2(5, Globals.player_position.y) / 2
			self.apply_impulse(Vector2(0, randi_range(-1055, 200)))

func _on_timer_timeout():
	queue_free()

func _on_area_2d_area_entered(area):
	print("collided with = ", area.name)
	
	if area.name == "AreaRope":
		var area_rope: Area2D = area
		var colission_rope = area.get_node("CollisionRope")
		var engineer: CharacterBody2D = area_rope.get_parent()
		
		reparent(colission_rope)

func _on_body_shape_entered(body_rid: RID, body: Node, body_shape_index: int, local_shape_index: int) -> void:
	print('COLLIDED WITH FLOOR: ', body.name)
