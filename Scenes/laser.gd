extends Area2D
@export var speed = 2000

func _ready():
	$Sprite2D.scale = Vector2(0,0)
	var tween = create_tween()
	tween.tween_property($Sprite2D, 'scale', Vector2(1,1),0.1)

func _process(delta):
	position.y -= speed * delta
	if position.y <= 0:
		Global.score -= 1
		queue_free()
