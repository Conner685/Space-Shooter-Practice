extends Area2D

signal collision

#random num generator
var rng := RandomNumberGenerator.new()
var speed = rng.randi_range(200,  1000)
var rotation_speed = rng.randf_range(-2.0,2.0)
var launch_direction = rng.randf_range(-1.0,1.0)
var size = rng.randf_range(.2, 2.0)

var can_collide := true

func _ready():
	#Start position 
	var width = get_viewport().get_visible_rect().size[0] #getting the width of the window
	var random_x = rng.randi_range(0, width)
	var random_y = rng.randi_range(-150, -50)
	scale = Vector2(size, size)
	position = Vector2(random_x, random_y)
	
	#Unused randomize texture code (remove active texture)
	#var path: String = "Insert path to meteor image" + random value + "ending of meteor path"
	#$Sprite2D.texture = lead(path)
	

func _process(delta):
	position += Vector2(launch_direction, 1.0) * speed * delta / size
	rotation += rotation_speed * delta / size
	#Deletes meteor once past player
	if position.y > (get_viewport().get_visible_rect().size[1]+300):
		queue_free()

func _on_body_entered(_body):
	if can_collide == true:
		collision.emit()


func _on_area_entered(area):
	area.queue_free()
	$ExplosionSound.play()
	#Allows for the sound to play whilst not harming player
	#can_collide = false
	#$Sprite2D.hide()
	#Delays code
	#await get_tree().create_timer(0.5).timeout
	queue_free()
	Global.score += 2
