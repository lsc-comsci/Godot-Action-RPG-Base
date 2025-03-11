extends Node2D

func _ready():
	pass
func _on_LeftSide_body_entered(body):
	if body.is_in_group("Player"):
		$YSort/Player.position = $Position/Position2D2.position
		
	pass # Replace with function body.

func _on_RightSide_body_entered(body):
	if body.is_in_group("Player"):
		$YSort/Player.position = $Position/Position2D.position
		
	pass # Replace with function body.
