extends Node2D
var rng:= RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	var pos_x = rng.randi_range(0, int(get_viewport().get_visible_rect().size[0]))
	var pos_y = rng.randi_range(0, int(get_viewport().get_visible_rect().size[1]))
	var star_size = randf_range(.5,3)
	
	scale = Vector2(star_size,star_size)
	position = Vector2(pos_x, pos_y)


func _on_star_life_timeout():
	queue_free()
