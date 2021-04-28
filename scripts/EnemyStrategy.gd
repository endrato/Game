extends KinematicBody2D


var max_HP=100
var current_hp=100

func _ready():
	current_hp=max_HP
	
func onHit(dmg):
	current_hp -=dmg
	print("current life = " + str(current_hp))
	if(current_hp<1):
		queue_free()


# Called when the node enters the scene tree for the first time.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
