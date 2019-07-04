extends Area2D

func _on_Fall_zone_body_entered(body):
	if body.has_method("die"):
		body.call("die")