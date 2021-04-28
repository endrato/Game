extends Area2D

var shot_y = 0
var shot_x = 0
var velocity = Vector2()
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	set_physics_process(false)
	
func shoot(dirVector,speed,positionBody):
	visible = true
	position = positionBody
	shot_y = dirVector.y *speed
	shot_x = dirVector.x *speed
	set_physics_process(true)
	
func _physics_process(delta):
	velocity.y = shot_y
	velocity.x = shot_x
	position = velocity * delta
	
	# We don't need to multiply velocity by delta because "move_and_slide" already takes delta time into account.

	# The second parameter of "move_and_slide" is the normal pointing up.
	# In the case of a 2D platformer, in Godot, upward is negative y, which translates to -1 as a normal.
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
