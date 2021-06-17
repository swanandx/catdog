extends CanvasLayer

signal play_again

func _on_PlayAgain_pressed():
	emit_signal("play_again")

func show_win(texture, text, sound):
	$Control/TextureRect.texture = texture
	$Control/Label.text = text
	yield(get_tree().create_timer(0.2), "timeout")
	if sound == "cat":
		$Control/Meow.play()
	elif sound == "dog":
		$Control/Bark.play()
	else:
		pass

func _on_Quit_pressed():
	if get_tree().change_scene("res://StartScreen.tscn") != OK:
		print("An unexpected error occured while changing the scene")
