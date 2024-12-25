extends Node2D

const ENEMY_TYPE_ENUM = preload("res://enemies/enemy_type_enum.gd").EnemyType

@export var EnemyBat: PackedScene

@onready var player: Node2D = $Player
@onready var path_follow: PathFollow2D = $Path2D/PathFollow2D
@onready var parallax: Parallax2D = $Parallax2D

func _ready() -> void:
	parallax.autoscroll.x = Globals.game_speed
	
	_on_timer_enemy_spawn_timeout()

func _process(delta: float) -> void:
	pass

func _on_timer_enemy_spawn_timeout():
	var floor_or_fly = randi_range(0, 1)
	
	floor_or_fly = 0
	
	var enemy: EnemyBaseClass
	
	if floor_or_fly == 0:
		enemy = EnemyBat.instantiate()
	else:
		#enemy = CharacterEnemySkeleton.instantiate()
		pass

	if enemy.enemy_type == ENEMY_TYPE_ENUM.FLY:
		path_follow.progress_ratio = randf_range(0, 1)
		
		enemy.position.x = path_follow.position.x
		enemy.position.y = path_follow.position.y
		
		enemy.look_at(player.position)
	elif enemy.enemy_type == ENEMY_TYPE_ENUM.FLOOR:
		pass

	enemy.chase_player(enemy.enemy_type, player)

	add_child(enemy)
