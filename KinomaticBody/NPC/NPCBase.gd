extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var canTalk = false
var once = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if canTalk == true:
		if Input.is_action_just_pressed("ui_Yes"):
			if once == false:
				Global.InCutscene = true
				var Conversation = Dialogic.start("Testing/TestTimeline")
				add_child(Conversation)
				Conversation.connect("dialogic_signal",self, "dialogic_signal_event")
				once = true
	pass
func dialogic_signal_event(arg):
	if arg == "end":
		Global.InCutscene = false
		Global.IndiLook = false
func _on_PlayerDetection_body_entered(body):
	if body.is_in_group("Player"):
		canTalk = true
		Global.IndiLook = true
		once = false


func _on_PlayerDetection_body_exited(body):
	if body.is_in_group("Player"):
		canTalk = false
		Global.IndiLook = false
	pass # Replace with function body.
