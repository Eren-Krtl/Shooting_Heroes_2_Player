extends CharacterBody2D

signal P1_LOST()

@onready var ShootTimer:Timer = %ShootTimer
@onready var HPBar:ProgressBar = %HPBar
@export var Bullet:PackedScene

var Keys = {
	"Up": "P1_Up",
	"Down": "P1_Down",
	"Left": "P1_Left",
	"Right": "P1_Right",
	"Shoot": "P1_Shoot",
	"Action": "P1_Action"
	}

var BulletStats = {
	"bullet": null,
	"target": "P2",
	"speed": GlobalPlayer.P1.BulletSpeed,
	"damage": GlobalPlayer.P1.BulletDamage,
	"repeat": GlobalPlayer.P1.BulletRepeat,
	"spread": GlobalPlayer.P1.BulletSpread
	}

var HP:float = GlobalPlayer.P1.HP
var Lost:bool = false

var IsAiming:bool = false

var CanShoot:bool = true
var IsShooting:bool = false

var MoveVelocity:Vector2
var SlideVelocity:Vector2

func _ready() -> void:
	BulletStats.bullet = Bullet
	HPBar.max_value = GlobalPlayer.P1.HP

func _physics_process(delta: float) -> void:
	GlobalPlayer.movement_logic(self, %Sprite, GlobalPlayer.Nodes.P2, GlobalPlayer.P1.Acceleration, GlobalPlayer.P1.MaxSpeed, Keys)
	shoot_logic()
	hp_logic()
	
func _input(event: InputEvent) -> void:
	if(event.is_action_pressed("P1_Shoot")):
		IsShooting = true
	if(event.is_action_released("P1_Shoot")):
		IsShooting = false
	if(event.is_action_pressed("P1_Action")):
		IsAiming = !IsAiming
# == LOGIC FOR SHOOTING BULLETS ==
func shoot_logic() -> void:
	if(CanShoot == true && IsShooting == true):
		# -- Instantiate bullet --
		GlobalPlayer.shoot_bullet(self, %Sprite, BulletStats)
		CanShoot = false
		# -- Set the shoot timer wait time to match the cooldown --
		ShootTimer.wait_time = GlobalPlayer.P1.BulletCooldown
		ShootTimer.start()
	return

func hp_logic():
	HPBar.value = HP
	if(HP <= 0 && Lost == false):
		Lost = true
		emit_signal("P1_LOST")

func _on_shoot_timer_timeout() -> void:
	CanShoot = true
