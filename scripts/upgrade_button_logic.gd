extends Button

var TargetPlayer:String
var Target

var Players = {
	"P1" = GlobalPlayer.P1,
	"P2" = GlobalPlayer.P2
}

var Ability = {
	"0" = ["BulletDamage", 3, "Moderetaly increases damage"],
	"1" = ["BulletSpeed", 100, "Moderetaly increases bullet speed"],
	"2" = ["BulletSpeed", -150, "BulletCooldown", -0.1, "Increases attack speed"],
	"3" = ["BulletRepeat", 1, "BulletDamage", -3, "BulletSpread", 1, "Shot more bullets with less damage and more spread"],
	"4" = ["HP", 50, "Get more HP"],
	"5" = ["BulletSpread", -2, "More accurate shots"]
}

var Stat:int
var SearchStat:String
var UnwrappedStat

func _ready() -> void:
	await get_tree().create_timer(0.1).timeout
	Target = Players[TargetPlayer]
	Stat = randi_range(0, Ability.size()-1)
	# -- SearchStat is stat turned into a string to go into the ability dictionary --
	SearchStat = str(Stat)
	# -- UnwrappedStat is Ability array that is selected --
	UnwrappedStat = Ability[SearchStat]
	print(Stat)
	self.text = UnwrappedStat[-1]

func _on_pressed() -> void:
	# -- Get every string of the array except the last one --
	var i:int = 0
	while(i < UnwrappedStat.size()-1):
		Target[UnwrappedStat[i]] += UnwrappedStat[i+1] 
		print(Target[UnwrappedStat[i]])
		print(UnwrappedStat[i+1])
		i += 2
	get_tree().change_scene_to_file("res://main_game.tscn")
