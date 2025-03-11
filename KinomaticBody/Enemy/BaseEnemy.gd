extends KinematicBody2D
# Movement speed
export var speed = 85
var player_position
var target_position
var TargetingPlayer = false
# Get a reference to the player. It's likely different in your project
onready var player = get_parent().get_node("Player")
func _physics_process(delta):
	
		if Global.InCutscene == false:
				if TargetingPlayer == true:
					# Set player_position to the position of the player node
					player_position = player.position
					# Calculate the target position
					target_position = (player_position - position).normalized()
					# Check if the enemy is in a 3px range of the player, if not move to the target position
					if position.distance_to(player_position) > 3:
							move_and_slide(target_position * speed)
					if target_position == Vector2.ZERO:
							$AnimationTree.get("parameters/playback").travel("Idle")
					else:
							$AnimationTree.get("parameters/playback").travel("Walk")
							$AnimationTree.set("parameters/Idle/blend_position", target_position)
							$AnimationTree.set("parameters/Walk/blend_position", target_position)

func _on_PlayerDetection_body_entered(body):
	if body.is_in_group("Player"):
		#$LookPlayer.play()
		$AnimationPlayer.play("Suprised")
		yield($AnimationPlayer, "animation_finished")
		TargetingPlayer = true
		pass # Replace with function body.
func _on_PlayerDetection_body_exited(body):
	if body.is_in_group("Player"):
		TargetingPlayer = false
		#$Quistion.play()
		$AnimationTree.set("parameters/Idle/blend_position", target_position)
		pass # Replace with function body.
func _on_PlayerCollision_body_entered(body):
	if body.is_in_group("Player"):
		pass
