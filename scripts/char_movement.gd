extends KinematicBody2D
const GRAVITY = 350.0
const WALK_SPEED = 300
const JUMP_VELOCITY = 250
const MAX_COINS = 100
const SHOOT_SPEED = 500
const ROF = 1.5
const SHOOT_RANGE = 3
var damage = 25
var gun = preload("res://Scenes/GunScene.tscn")
var gun_pos = Vector2()
var coins = 0
var velocity = Vector2()
var shooting = false
var can_shoot = true
var direcVector = Vector2()


func _ready():
	
	set_physics_process(true)
	set_process(true)

func add_coin():
	if(coins<MAX_COINS):
		coins +=1
func jump_cut():
	if velocity.y < -100:
		velocity.y = -100
func jump():
	velocity.y = -JUMP_VELOCITY
func shootprocess():
	if Input.is_action_pressed("shoot_up"):
		direcVector.y = -1
		gun_pos.y = position.y-40
		gun_pos.x = position.x 
		shooting = true
	if Input.is_action_pressed("shoot_down"):
		direcVector.y = 1
		gun_pos.y = position.y+40
		gun_pos.x = position.x 
		shooting = true
	if Input.is_action_pressed("shoot_right"):
		direcVector.x = 1
		gun_pos.y = position.y
		gun_pos.x = position.x+44 
		shooting = true
	if Input.is_action_pressed("shoot_left"):
		direcVector.x = -1
		gun_pos.y = position.y
		gun_pos.x = position.x-44 
		shooting = true
	if (shooting and can_shoot):
		shoot()
		yield(get_tree().create_timer(0.1),"timeout")
		shooting = false
		direcVector.x=0
		direcVector.y=0	
		
		
func shoot():
	can_shoot=false
	var BulletBody = gun.instance()
	BulletBody.initialize(direcVector,SHOOT_SPEED,SHOOT_RANGE,gun_pos,damage)
	get_parent().add_child(BulletBody)
	var BULLET_POSITIONLBL = get_parent().get_node("Counter/HUD/Control3/BULLET_POSITION")
	BULLET_POSITIONLBL.text= "bp= " + str(int(BulletBody.position.x)) + " , " +str(int(BulletBody.position.y)) 
	yield(get_tree().create_timer(ROF),"timeout")
	can_shoot=true
	
func _process(delta):
	var LabelNode = get_parent().get_node("Counter/HUD/Control/RichTextLabel")
	LabelNode.text = str(coins)
	var CHAR_POSITIONLBL = get_parent().get_node("Counter/HUD/Control2/CHAR_POSITION")
	CHAR_POSITIONLBL.text= "cp= " + str(int(position.x)) + " , " + str(int(position.y))
	shootprocess()
	
func _physics_process(delta):
	velocity.y += delta * GRAVITY
	if Input.is_action_just_pressed("up"):
		if is_on_floor():
			jump()
	if Input.is_action_just_released("up"):
		jump_cut()	
	if Input.is_action_pressed("left"):
		velocity.x = -WALK_SPEED
	elif Input.is_action_pressed("right"):
		velocity.x =  WALK_SPEED
	else:
		velocity.x = 0

	# We don't need to multiply velocity by delta because "move_and_slide" already takes delta time into account.

	# The second parameter of "move_and_slide" is the normal pointing up.
	# In the case of a 2D platformer, in Godot, upward is negative y, which translates to -1 as a normal.
	move_and_slide(velocity, Vector2(0, -1))


func _on_coin_body_entered(body):
	add_coin()
