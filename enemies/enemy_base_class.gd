extends CharacterBody2D

class_name EnemyBaseClass

const ENEMY_TYPE_ENUM = preload("res://enemies/enemy_type_enum.gd").EnemyType

@export var enemy_type: ENEMY_TYPE_ENUM = ENEMY_TYPE_ENUM.FLY

var is_hitting_barrier = false

var enemy_velocity := 10
var enemy_strength := 8
var enemy_health := 5

func chase_player(_enemy_type: ENEMY_TYPE_ENUM, _player: PlayerClass):
	if enemy_type == ENEMY_TYPE_ENUM.FLOOR:
		position.x -= _player.position.direction_to(position).x
		velocity.x = enemy_velocity * position.direction_to(_player.position).x

	elif enemy_type == ENEMY_TYPE_ENUM.FLY:
		position -= _player.position.direction_to(position)
		velocity = enemy_velocity * position.direction_to(_player.position)

func enemy_move(delta):
	if not is_hitting_barrier:
		if enemy_type == ENEMY_TYPE_ENUM.FLOOR:
			move_local_x(delta * velocity.x)
		elif enemy_type == ENEMY_TYPE_ENUM.FLY:
			move_and_collide(velocity * delta)
