extends Node2D
var rng := RandomNumberGenerator.new()
#load the scene
var met_sc1: PackedScene = load("res://Scenes/meteor.tscn")
var met_sc2: PackedScene = load("res://Scenes/meteor2.tscn")
var met_sc3: PackedScene = load("res://Scenes/meteor3.tscn")
var met_sc4: PackedScene = load("res://Scenes/meteor4.tscn")
var laser_scene: PackedScene = load("res://Scenes/laser.tscn")
var star_scene: PackedScene = load("res://Scenes/star.tscn")

var health: int = 5

func _ready():
	#set health ui
	get_tree().call_group('ui', 'set_health', health)
	Global.score = 0

func _on_meteor_timer_timeout():
	#randomize the meteor
	var met_scenes = [met_sc1, met_sc2, met_sc3, met_sc4]
	var rand_met = rng.randi_range(0, met_scenes.size()-1)
	#create instance
	var meteor = met_scenes[rand_met].instantiate()
	
	#attach the node to the scene tree
	$Meteors.add_child(meteor)
	
	#Connect the signal
	meteor.connect('collision', _on_meteor_collision)
	
func _on_meteor_collision():
	health -= 1
	get_tree().call_group('ui', 'set_health', health)
	if health <= 0:
		get_tree().change_scene_to_file("res://Scenes/game_over_ui.tscn")
	$Player.play_collision_sound()


func _on_player_laser(pos):
	var laser = laser_scene.instantiate()
	$Lasers.add_child(laser)
	laser.position = pos


func _on_star_spawner_timeout():
	var star = star_scene.instantiate()
	var star_rate = rng.randf_range(0,1)
	$Stars.add_child(star)
	$Stars/StarSpawner.start(star_rate)
