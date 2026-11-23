extends CharacterBody2D

signal P2_LOST()

@onready var ShootTimer:Timer = %ShootTimer
@onready var HPBar:ProgressBar = %HPBar
@export var Bullet:PackedScene

var Keys = {
	"Up" = "P2_Up",
	"Down" = "P2_Down",
	"Left" = "P2_Left",
	"Right" = "P2_Right",
	"Shoot" = "P2_Shoot",
	"Action" = "P2_Action"
	}

var HP:float = GlobalPlayer.P2.HP
var Lost:bool = false

var IsAiming:bool = false

var CanShoot:bool = true
var IsShooting:bool = false

var MoveVelocity:Vector2
var SlideVelocity:Vector2

func _ready() -> void:
	HPBar.max_value = GlobalPlayer.P2.HP

func _physics_process(delta: float) -> void:
	GlobalPlayer.movement_logic(self, %Sprite, GlobalPlayer.P2.Acceleration, GlobalPlayer.P2.MaxSpeed, Keys)
	shoot_logic()
	hp_logic()

func _input(event: InputEvent) -> void:
	if(event.is_action_pressed("P2_Shoot")):
		IsShooting = true
	if(event.is_action_released("P2_Shoot")):
		IsShooting = false

# == LOGIC FOR SHOOTING BULLETS ==
func shoot_logic() -> void:
	if(CanShoot == true && IsShooting == true):
		# -- Instantiate bullet --
		GlobalPlayer.shoot_bullet(self, %Sprite, Bullet, "P1", GlobalPlayer.P2.BulletSpeed, GlobalPlayer.P2.BulletDamage, GlobalPlayer.P2.BulletRepeat, GlobalPlayer.P2.BulletSpread)
		CanShoot = false
		# -- Set the shoot timer wait time to match the cooldown --
		ShootTimer.wait_time = GlobalPlayer.P2.BulletCooldown
		ShootTimer.start()
	return

func hp_logic():
	HPBar.value = HP
	if(HP <= 0 && Lost == false):
		Lost = true
		emit_signal("P2_LOST")

func _on_shoot_timer_timeout() -> void:
	CanShoot = true
