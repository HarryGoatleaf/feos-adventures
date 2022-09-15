extends StaticBody2D

func ignite():
	$PappeSprite.play("ignite")
	$PappeCollider.queue_free()
