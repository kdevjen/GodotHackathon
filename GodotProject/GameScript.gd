extends Node

var random_pick

var button_colors = ["red_button", "blue_button", "purple_button", "yellow_button", "green_button"]

var random_list = [] #full sequence, in order, of the buttons that have been randomly chosen

var pressed_list = [] #list of buttons that the user has pressed this turn

# Called when the node enters the scene tree for the first time.
func _ready():
	_stopglow()
	_pick_button()
	$Window/AcceptDialog.hide()
	
func _process(delta):
	pass
	
#when the user presses a button...
func _button_pressed(button):
	pressed_list.append(button)
	while len(pressed_list) <= len(random_list):
		var index = 0
		for i in pressed_list:
			index = pressed_list.find(i)
			if pressed_list[index] == random_list[index]:
				pass
			else:
				_game_over()
				break
		#if all previous buttons have been pressed in the correct order...
		if pressed_list == random_list:
			_pick_button()
		elif len(pressed_list) < len(random_list):
			break
		else:
			_game_over()
			break

#picks a button from the random list
func _pick_button():
	pressed_list.clear() 
	random_pick = button_colors[randi() % button_colors.size()]
	random_list.append(random_pick)

	for i in random_list:
	
		_make_glow(i)
		await get_tree().create_timer(0.8).timeout
		
		_stopglow()
		await get_tree().create_timer(0.2).timeout
	
#this one's mad ugly but i am so tired sorry	
func _make_glow(i):
	if i == 'blue_button':
		$blue_button/ColorRect.show()

	elif i == 'red_button':
		$red_button/ColorRect.show()

	elif i == 'green_button':
		$green_button/ColorRect.show()

	elif i == 'yellow_button':
		$yellow_button/ColorRect.show()

	elif i == 'purple_button':
		$purple_button/ColorRect.show()

#stop the overlayed colors from showing after 0.8 seconds
func _stopglow():
	$blue_button/ColorRect.hide()
	$red_button/ColorRect.hide()
	$yellow_button/ColorRect.hide()	
	$green_button/ColorRect.hide()
	$purple_button/ColorRect.hide()	
		
func _game_over():
	#woe befell the horizon of man!
	$Window/AcceptDialog.show()
	get_tree().change_scene_to_file("res://title_screen.tscn")
