extends Control

@export var Target:String

func _ready() -> void:
	%PlayerName.text = Target
	for i in get_children():
		if(i.is_in_group("UpgradeButton")):
			i.TargetPlayer = Target 
