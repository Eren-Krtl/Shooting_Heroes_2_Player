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

var ScoreToEnd:int


func movement_logic(player:CharacterBody2D, sprite:Sprite2D, Acceleration:float, MaxSpeed:float, keys:Dictionary):
	var move_direction = Input.get_vector(keys.Left, keys.Right, keys.Up, keys.Down)
	var Friction:float = 0.95
	if(move_direction != Vector2.ZERO):
		sprite.rotation = move_direction.angle()
		Friction = 0.99
	if(player.IsAiming == false):
		player.MoveVelocity += move_direction * Acceleration
		player.MoveVelocity *= Friction
	else:
		player.MoveVelocity = MaxSpeed/2 * move_direction
	player.MoveVelocity = Vector2(clampf(player.MoveVelocity.x, -MaxSpeed, MaxSpeed), clampf(player.MoveVelocity.y, -MaxSpeed, MaxSpeed))
	player.velocity = player.MoveVelocity + player.SlideVelocity
	player.move_and_slide()
	return

func shoot_bullet(player:CharacterBody2D, sprite:Sprite2D, bullet:PackedScene, Target:String, Speed:float, Damage:float, repeat:int, spread:float):
	for i in repeat+1:
		var prebullet = bullet.instantiate()
		prebullet.position = player.position
		var shoot_angle = sprite.global_rotation_degrees + randf_range(-spread, spread)
		prebullet.global_rotation_degrees = shoot_angle
		prebullet.Speed = Speed
		prebullet.Damage = Damage
		prebullet.TARGET = Target
		player.add_sibling(prebullet)
		sprite.get_node("JumpParticles").emitting = true
		await get_tree().create_timer(0.1).timeout
