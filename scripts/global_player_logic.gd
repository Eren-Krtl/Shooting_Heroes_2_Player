extends Node

var P1 = {
	"Score": 0,
	"HP": 25.0,
	"Acceleration": 5.0,
	"MaxSpeed": 150.0,
	"BulletDamage": 5.0,
	"BulletCooldown": 0.5,
	"BulletSpeed": 400.0,
	"BulletRepeat": 0,
	"BulletSpread": 3.0,
}

var P2 = {
	"Score": 0,
	"HP": 25.0,
	"Acceleration": 5.0,
	"MaxSpeed": 150.0,
	"BulletDamage": 5.0,
	"BulletCooldown": 0.5,
	"BulletSpeed": 400.0,
	"BulletRepeat": 0,
	"BulletSpread": 3.0,
}

var Nodes = {
	"P1": 1,
	"P2": 2,
	}

var ScoreToEnd:int

func movement_logic(player:CharacterBody2D, sprite:Sprite2D, Target:Node2D, Acceleration:float, MaxSpeed:float, keys:Dictionary):
	var move_direction = Input.get_vector(keys.Left, keys.Right, keys.Up, keys.Down)
	var Friction:float = 0.95
	if(player.IsAiming == false):
		if(move_direction != Vector2.ZERO):
			sprite.global_rotation = move_direction.angle()
			Friction = 0.99
		player.MoveVelocity += move_direction * Acceleration
		player.MoveVelocity *= Friction
	else:
		player.MoveVelocity = MaxSpeed/2 * move_direction
		sprite.global_rotation = player.position.direction_to(Target.position).angle()
	player.MoveVelocity = Vector2(clampf(player.MoveVelocity.x, -MaxSpeed, MaxSpeed), clampf(player.MoveVelocity.y, -MaxSpeed, MaxSpeed)) # limits the MoveVelocity to max speed
	player.velocity = player.MoveVelocity + player.SlideVelocity
	player.move_and_slide()
	return

func shoot_bullet(player:CharacterBody2D, sprite:Sprite2D, BulletStats:Dictionary):
	var Damage = BulletStats.damage
	var Spread = BulletStats.spread
	var Speed = BulletStats.speed
	if(player.IsAiming == true):
		Damage *= 0.5
		Spread *= 1.5
		Speed *= 0.8
	for i in BulletStats.repeat+1:
		var prebullet = BulletStats.bullet.instantiate()
		prebullet.position = player.position
		var shoot_angle = sprite.global_rotation_degrees + randf_range(-Spread, Spread)
		prebullet.global_rotation_degrees = shoot_angle
		prebullet.Speed = Speed
		prebullet.Damage = Damage
		prebullet.TARGET = BulletStats.target
		player.add_sibling(prebullet)
		sprite.get_node("JumpParticles").emitting = true
		await get_tree().create_timer(0.1).timeout
