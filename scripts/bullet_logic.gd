extends CharacterBody2D

var TARGET:String
var Damage:float
var Speed:float

var MoveVelocity:Vector2
var ForcedVelocity:Vector2

func _physics_process(delta: float) -> void:
	movement_logic()
	velocity = MoveVelocity + ForcedVelocity
	move_and_slide()

# == BULLET COLLIDIING AND DEALING DAMAGE ==
func _on_area_2d_area_entered(area: Area2D) -> void:
	if(area.is_in_group(TARGET)):
		print("Hit")
		area.get_parent().HP -= maxf(Damage, 1)
		queue_free()

# == MOVE LOGIC ==
func movement_logic() -> void:
	MoveVelocity = transform.x * Speed
