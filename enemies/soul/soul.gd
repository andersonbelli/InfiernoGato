extends RigidBody2D

class_name Soul

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var timer = $Timer
@onready var soul: Sprite2D = $Soul

var floating = false

var shard_value = 1

func _process(delta):
	if timer.time_left < 2 && not timer.is_stopped():
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

func soul_absorbed():
	timer.stop()
	animation_player.play("absorbed")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "absorbed":
		queue_free()
