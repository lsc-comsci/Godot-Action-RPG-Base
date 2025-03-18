extends KinematicBody2D
# can talk checks if the player is in the area of the NPC
var canTalk = false
# is used to only call the dialouge once
var once = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# if the player IS in the area of the NPC then you can interact with the NPC
	if canTalk == true:
		if Input.is_action_just_pressed("ui_Yes"):
			if once == false:
				Global.InCutscene = true
				var Conversation = Dialogic.start("Testing/TestTimeline")
				add_child(Conversation)
				Conversation.connect("dialogic_signal",self, "dialogic_signal_event")
				once = true
	pass
# this function is connected to the dialougic pluggin an is called when dialougic sends the signal "dialogic_signal" to the scene
func dialogic_signal_event(arg):
	# if the end is called from the dialogic timeline then the player will mpve again 
	if arg == "end":
		Global.InCutscene = false
		Global.IndiLook = false
func _on_PlayerDetection_body_entered(body):
	if body.is_in_group("Player"):
		# the the player enters the NPC node then you can interact with it
		canTalk = true
		Global.IndiLook = true
		once = false


func _on_PlayerDetection_body_exited(body):
	if body.is_in_group("Player"):
		# the the player leaves the NPC node then you can no longer interact with it
		canTalk = false
		Global.IndiLook = false
	pass # Replace with function body.
