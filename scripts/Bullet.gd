extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var Velocity = Vector2()
var rangeshot = 0

func initialize(dirVector,SHOOT_SPEED,SHOOT_RANGE,gun_position):
	Velocity.x =dirVector.x*SHOOT_SPEED
	Velocity.y =dirVector.y*SHOOT_SPEED
	rangeshot = SHOOT_RANGE
	set_position(gun_position)
	apply_impulse(Vector2(),Velocity)
# Called when the node enters the scene tree for the first time.
func _ready():
	yield(get_tree().create_timer(rangeshot),"timeout")
	queue_free()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Gun_body_entered(body):
	queue_free()
