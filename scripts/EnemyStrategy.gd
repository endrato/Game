extends KinematicBody2D

onready var player = get_parent().get_node("Player")
var max_HP=100
var current_hp=100
var player_inrange
var player_in_sight


func _ready():
	current_hp=max_HP
	
func onHit(dmg):
	current_hp -=dmg
	print("current life = " + str(current_hp))
	if(current_hp<1):
		queue_free()
func _physics_process(delta):
	checksight()

func checksight():
	if player_inrange==true:
		var space_state = get_world_2d().direct_space_state
		var sight_check = space_state.intersect_ray(position,player.position,[self],collision_mask)
		if sight_check:
			print(sight_check.collider.name)
			if sight_check.collider.name=="Player":
				player_in_sight==true
				print("se le ve")
			else:
				player_in_sight==false
				print("no se le ve")
# Called when the node enters the scene tree for the first time.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Linea_de_vision_body_entered(body):
	if body==player:
		player_inrange=true
		print("rango")

func _on_Linea_de_vision_body_exited(body):
	if body==player:
		player_inrange=false
		print("no rango")
