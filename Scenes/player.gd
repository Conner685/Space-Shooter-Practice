extends CharacterBody2D
@export var speed: int = 800
var can_shoot: bool = true

signal laser(pos)


# Called when the node enters the scene tree for the first time.
func _ready():
	position = Vector2(960,800)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var direction = Input.get_vector("move_left", "move_right","move_up","move_down")
	velocity = direction * speed
	move_and_slide()
	
	#shoot input
	if Input.is_action_pressed("Shoot") && can_shoot:
		laser.emit($LaserSpawnPoint.global_position)
		Global.score -= 1
		can_shoot = false
		$FireRate.start()
		$LaserSound.play()
		
func play_collision_sound():
	$DamageSound.play()


func _on_fire_rate_timeout():
	can_shoot = true
