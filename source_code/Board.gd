extends Node2D

var board = {1:"",2:"",3:"",4:"",5:"",6:"",7:"",8:"",9:""}

var cat = load("res://assests/cat.png")
var dog = load("res://assests/dog.png")
var draw = load("res://assests/dogcat.png")
var textures = {"cat":cat,"dog":dog}
var single_player
var game_over = false

export(bool) var isMyTurn = true
var moves = 0
var charecter = GlobalTextureRect.my_char

func _ready() -> void:
	$Menu/Control.hide()
	single_player = GlobalTextureRect.single_player

func switch():
	if charecter == "cat":
		charecter = "dog"
	else:
		charecter = "cat"

func try_make_move(pos:int,mo : String):
	if not isMyTurn:
		return
	if not single_player:
		if board[pos] == "":
			make_move(pos,mo)
			$Movesound.play()
	else:
		if board[pos] == "":
			make_move(pos,mo)
			$Movesound.play()
			isMyTurn = false
			yield(get_tree().create_timer(0.3), "timeout")
			if mo == "cat":
				computer_move("dog","cat")
			else:
				computer_move("cat","dog")


func check_win(move):
	var winner
	if board[1] == board[2] and board[2] == board[3] and board[1] == move:
		winner = true
	elif board[4] == board[5] and board[5] == board[6] and board[4] == move:
		winner = true
	elif board[7] == board[8] and board[8] == board[9] and board[7] == move:
		winner = true
	elif board[1] == board[4] and board[4] == board[7] and board[1] == move:
		winner = true
	elif board[2] == board[5] and board[5] == board[8] and board[2] == move:
		winner = true
	elif board[3] == board[6] and board[6] == board[9] and board[3] == move:
		winner = true
	elif board[3] == board[5] and board[5] == board[7] and board[5] == move:
		winner = true
	elif board[1] == board[5] and board[5] == board[9] and board[5] == move:
		winner = true
	else:
		winner = false
	return winner

func make_move(pos:int,turn: String):
	if game_over and not isMyTurn:
		return
	moves += 1
	var area = get_child(pos)
	var s = Vector2()
	s.x = 0.25
	s.y = 0.25
	if turn == "cat":
		board[pos] = "cat"
		area.get_node("Sprite").texture = cat
		area.get_node("Sprite").scale = s
	else:
		board[pos] = "dog"
		area.get_node("Sprite").texture = dog
		area.get_node("Sprite").scale = s
	
	if check_win(turn):
		$Menu/Control.show()
		if turn == GlobalTextureRect.my_char and single_player:
			$Menu.show_win(textures[turn] , "You won!", turn)
		else:
			$Menu.show_win(textures[turn] , turn + " won", turn)
		game_over = true
	elif moves == 9:
		$Menu/Control.show()
		$Menu.show_win(draw, "Draw", "draw")
		game_over = true
	switch()

func computer_move(comp,move):
	var move_made = false
	var blank = []
	for key in board:
		if board[key] == "":
			blank.append(key)
			board[key] = comp
			if check_win(comp):
				board[key] = ""
				make_move(key,comp)
				move_made = true
				break
			else:
				board[key] = ""
	if not move_made and blank.size() > 0:
		for i in blank:
			board[i] = move
			if check_win(move):
				board[i] = ""
				make_move(i,comp)
				move_made = true
				break
			else:
				board[i] = ""
	if not move_made and blank.size() > 0:
		var choice = blank[randi() % blank.size()]
		make_move(choice,comp)
	isMyTurn = true

func event_handler(event : InputEvent, pos : int):
	if event is InputEventScreenTouch and event.pressed:
		try_make_move(pos,charecter)

func _on_Area1_input_event(_viewport, event, _shape_idx):
	event_handler(event,1)

func _on_Area2_input_event(_viewport, event, _shape_idx):
	event_handler(event,2)

func _on_Area3_input_event(_viewport, event, _shape_idx):
	event_handler(event,3)

func _on_Area4_input_event(_viewport, event, _shape_idx):
	event_handler(event,4)

func _on_Area5_input_event(_viewport, event, _shape_idx):
	event_handler(event,5)

func _on_Area6_input_event(_viewport, event, _shape_idx):
	event_handler(event,6)

func _on_Area7_input_event(_viewport, event, _shape_idx):
	event_handler(event,7)

func _on_Area8_input_event(_viewport, event, _shape_idx):
	event_handler(event,8)

func _on_Area9_input_event(_viewport, event, _shape_idx):
	event_handler(event,9)

func _on_Menu_play_again():
	if get_tree().reload_current_scene() != OK:
		print("An unexpected error occured while changing the scene")
