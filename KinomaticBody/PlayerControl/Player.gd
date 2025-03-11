extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var speed = 80
var runspeed = 100
var pause = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
#yield($AnimationPlayer2, "animation_finished")
#yield(get_tree().create_timer(3),"timeout")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# checks when the player can push Z it will show Z on the head
	if Global.IndiLook == true:
		$Interaction.visible = true
	else:
		$Interaction.visible = false
	pass
func _physics_process(delta):
	if Global.InCutscene == false:
		# this changes speed if the player runs
		if Input.is_action_pressed("Run"):
			speed = runspeed
		elif Input.is_action_just_released("Run"):
			# speed goes back to normal when run is released
			speed = 80
		var input_vector = Vector2.ZERO
		# basic movement program
		input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
		input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
		input_vector = input_vector.normalized()
		# checks if the player isn't moving
		if input_vector == Vector2.ZERO:
			# plays the idle animation if it does
			$AnimationTree.get("parameters/playback").travel("Idle")
		else:
			# if the player isn't moveing then it moves the payer
			$AnimationTree.get("parameters/playback").travel("Walk")
			move_and_slide(input_vector * speed)
			$AnimationTree.set("parameters/Idle/blend_position", input_vector)
			$AnimationTree.set("parameters/Walk/blend_position", input_vector)
	else:
		$AnimationTree.get("parameters/playback").travel("Idle")
