extends KinematicBody2D

var speed = 80
var runspeed = 100
var pause = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass
func _process(delta):
	# checks when the player can push Z it will show Z on the head
	if Global.IndiLook == true:
		# this node is visible when the global variable IndiLook is true
		$Interaction.visible = true
	else:
		# this node is visible when the global variable IndiLook is false
		$Interaction.visible = false
	pass
# physics process is for movement if you use regular process function for movement it wont work
func _physics_process(delta):
	# 
	if Global.InCutscene == false:
		# this changes speed if the player pushes the run button
		if Input.is_action_pressed("Run"):
			speed = runspeed
		elif Input.is_action_just_released("Run"):
			# speed goes back to normal when run is released
			speed = 80
		# creates a new variable called input_vector which will be used to check the players movement
		var input_vector = Vector2.ZERO
		# basic movement logic
		input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
		input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
		input_vector = input_vector.normalized()
		# checks if the player isn't moving
		if input_vector == Vector2.ZERO:
			# plays the idle animation if the player isnt moveing
			$AnimationTree.get("parameters/playback").travel("Idle")
		else:
			# if the player is moveing then the walk animation will play
			$AnimationTree.get("parameters/playback").travel("Walk")
			move_and_slide(input_vector * speed)
			$AnimationTree.set("parameters/Idle/blend_position", input_vector)
			$AnimationTree.set("parameters/Walk/blend_position", input_vector)
	else:
		# If the player is in a cutscene event then the animation will change to the idle state
		$AnimationTree.get("parameters/playback").travel("Idle")
