extends Node2D
# ready function automatically gets called for the first frame
func _ready():
	pass
	
# this function is called when the player collides with the Area 2D node called LeftSide
func _on_LeftSide_body_entered(body):
	#checks if the collision body is in the group player
	if body.is_in_group("Player"):
		#If the plyer body is detected then it moves the player to the posistion node
		$YSort/Player.position = $Position/Position2D2.position
	pass
# this function is called when the player collides with the Area 2D node called RightSide
func _on_RightSide_body_entered(body):
	#checks if the collision body is in the group player
	if body.is_in_group("Player"):
		#If the plyer body is detected then it moves the player to the posistion node
		$YSort/Player.position = $Position/Position2D.position
	pass
