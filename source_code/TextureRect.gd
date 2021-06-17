extends TextureRect

var single_player
var my_char = "cat"

func _on_Button_pressed():
	$Friends.hide()
	$catto.hide()
	$doggo.hide()
	$Button.hide()
	$cat.show()
	$dog.show()
	$choose.show()


func _on_Friends_pressed():
	GlobalTextureRect.single_player = false
	if get_tree().change_scene("res://Board.tscn") != OK:
		print("An unexpected error occured while changing the scene")

func start_game():
	GlobalTextureRect.single_player = true
	if get_tree().change_scene("res://Board.tscn") != OK:
		print("An unexpected error occured while changing the scene")

func _on_cat_pressed():
	GlobalTextureRect.my_char = "cat"
	start_game()

func _on_dog_pressed():
	GlobalTextureRect.my_char = "dog"
	start_game()
