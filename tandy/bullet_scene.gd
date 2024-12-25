extends RigidBody2D

class_name BulletClass

var bullet_damage := 1

func on_hit(enemy: EnemyBaseClass, hit_position):
	#call_deferred("reparent", enemy)
	#call_deferred("set_freeze_enabled", true)
	
	#linear_velocity = linear_velocity / 2000
	#constant_force =  constant_force / 1000
	print("enemy = ", enemy)
	queue_free()
