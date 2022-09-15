extends KinematicBody2D

# player signals
signal collision	# gets emitted if the player hits a wall
signal win			# gets emitted if the player reaches a goal
signal feuer
# variables for physics simulation
var velocity = Vector2(0,0)
var acceleration = Vector2(0,0)
var drag = Vector2()
var lift = Vector2()
# physics constants
var G = Vector2(0, 9.81)*100

# properties for input
# Intent is a vector representing the direktion the player intents to go
# a lot of bus if intent == 0. Kinda hacky. Change later
var intent = Vector2(0,0.01)
# maximal length of intent
var maxIntent = 100

# Handle input events
func _unhandled_input(event):
	if event is InputEventMouseMotion:
		# hack that prevents intent=0. change this
		if intent != event.relative:
			intent += event.relative
		
		# limit intent length to maxIntent
		intent = intent.clamped(maxIntent)
		# display move intent
		$DebugSprites/intentSprite.position = intent
	
	if event is InputEventMouseButton:
		if event.pressed:
			FIRE()
		else:
			nofire()


# physics loop
func _physics_process(delta):
	# physics
	# surface area
	var surface = (1.0+abs(sin(velocity.angle_to(intent))))
	# drag
	drag = -1*pow(velocity.length(), 2) *velocity.normalized()/800
	# lift
	lift = pow(velocity.length(), 2) * intent/maxIntent * surface / 1000
	
	# calc current acceleration
	acceleration = G + drag + lift
	# apply acceleration to velocity
	velocity += acceleration * delta
	# move the player and check for collisions
	var collision = move_and_collide(velocity * delta)
	
	# react to collisions
	handle_collision(collision)


# graphics loop
func _process(_delta):
	# rotate sprite
	$playerSprite.set_rotation(velocity.angle())
	#rotate fire object
	$Feuer.set_rotation(velocity.angle())
	# flip so sprite not upside down
	if velocity.x < 0:
		$playerSprite.flip_v = true
	else:
		$playerSprite.flip_v = false
	# display acceleration
	$DebugSprites/accelerationSprite.set_rotation(acceleration.angle()+ PI/2)
	$DebugSprites/accelerationSprite.scale.y = acceleration.length() * 0.0000045
	# display drag
	$DebugSprites/dragSprite.set_rotation(drag.angle()+ PI/2)
	$DebugSprites/dragSprite.scale.y = drag.length() * 0.0000045
	# display lift
	$DebugSprites/liftSprite.set_rotation(lift.angle()+ PI/2)
	$DebugSprites/liftSprite.scale.y = lift.length() * 0.0000045

# reset the player
func reset(pos):
	position = pos
	velocity = Vector2(0,0)
	acceleration = Vector2(0,0)


func handle_collision(collision):
	if collision:
		# The player body has collided
		if collision.collider.is_in_group("Walls") or collision.collider.is_in_group("Pappe"):
			if Global.enable_music:
				 $BumpSound.play()
			emit_signal("collision")
		elif collision.collider.is_in_group("Goal"):
			if Global.enable_music:
				$WinSound.play()  # doesn't work well with the tutorials
			emit_signal("win")
		else:
			print("Collision object doesn't belong to any of the expected groups")
			
func FIRE():
	# enable collision of FIRE object
	$Feuer.set_collision_layer_bit(0, 1)
	$Feuer.set_collision_mask_bit(0, 1)
	# SHOW FIRE ANIMATION
	$Feuer/FeuerSprite.play("feuer")
	
func nofire():
	# disable collision of fire object
	$Feuer.set_collision_layer_bit(0, 0)
	$Feuer.set_collision_mask_bit(0, 0)
	# hide fire object
	$Feuer/FeuerSprite.play("New Anim")

func burned_something(burned_body):
	if burned_body.is_in_group("Pappe"):
		burned_body.ignite()
