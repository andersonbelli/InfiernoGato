extends EnemyBaseClass

@export var EssenceShard: PackedScene
@export var Soul: PackedScene

@onready var timer_hit_cooldown = $TimerHitCooldown

@onready var animated_sprite = $AnimatedSprite2D

@onready var ray_cast = $RayCast2D

func _init():
	enemy_type = ENEMY_TYPE_ENUM.FLY
	enemy_velocity = 140
	
func _ready():
	if position.x > 640:
		animated_sprite.flip_v = true

func _physics_process(delta):
	if ray_cast.is_colliding() and ray_cast.get_collider() is PlayerClass:
		velocity = Vector2.ZERO
		
		if timer_hit_cooldown.is_stopped():
			timer_hit_cooldown.start()
	
	enemy_move(delta)

func _process(delta):
	if enemy_health <= 0:
		var soul = Soul.instantiate()
		soul.position = position
		
		get_parent().add_child(soul)
		queue_free()

func _on_area_2d_body_entered(body):
	if body is BulletClass:
		enemy_health -= body.bullet_damage
		body.on_hit(self, position)

func spawn_essence_shard():
	var item_drop: RigidBody2D = EssenceShard.instantiate()
	item_drop.position = position
	
	get_parent().add_child(item_drop)
