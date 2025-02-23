extends CanvasLayer

static var image = load("res://Space shooter(asset)/PNG/UI/playerLife1_orange.png")

func set_health(amount):
	#remove all children (reset current health count UI)
	for child in $MarginContainer2/HBoxContainer.get_children():
		child.queue_free()
	
	#create new children with amount set by health (set and live update health UI)
	for i in amount:
		var text_rect = TextureRect.new()
		text_rect.texture = image
		$MarginContainer2/HBoxContainer.add_child(text_rect)
		text_rect.stretch_mode = TextureRect.STRETCH_KEEP


func _on_score_timer_timeout():
	Global.score += 1
	$MarginContainer/Score.text = str(Global.score)

