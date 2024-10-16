extends Node2D

@onready var editor = $Editor

@onready var file_object = "user://TextFile.txt"
	
@onready var output = $output



func _ready():
	editor.text = FileAccess.open(file_object, FileAccess.READ).get_as_text()

	
	DisplayServer.virtual_keyboard_show("",Rect2(10,10,500,500),DisplayServer.KEYBOARD_TYPE_DEFAULT,-1,-1,-1)
	
	
	
	



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	


		

func _on_submit_button_pressed():
	editor.grab_focus()
	
	#DisplayServer.virtual_keyboard_show("",Rect2(10,10,500,500),DisplayServer.KEYBOARD_TYPE_DEFAULT,-1,-1,-1)
	var current_line = editor.get_caret_line()
	editor.set_caret_line(current_line+1)
	


func _on_quit_button_pressed():

	FileAccess.open(file_object, FileAccess.WRITE).store_string(editor.text)
	
	get_tree().quit()





# This function gets called for unhandled input events like touch or key presses
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_action_pressed("ui_cancel"):
		
		get_tree().quit()

	if event is InputEventMouseButton:
		pass
		#output.text = "mouse"

	if event is InputEventScreenTouch:
		
		var touch_event = event as InputEventScreenTouch
		
		output.text = str(touch_event.position)	
		# Simulate mouse click if the touch is within the TextEdit area
		simulate_mouse_click_for_textedit(touch_event.position)
		
		
# Function to simulate a mouse click event for TextEdit
func simulate_mouse_click_for_textedit(position: Vector2):
	var mouse_press_event = InputEventMouseButton.new()
	mouse_press_event.position = editor.get_local_mouse_position()
	mouse_press_event.global_position = position
	mouse_press_event.button_index = MOUSE_BUTTON_LEFT
	mouse_press_event.pressed = true
			
	Input.parse_input_event(mouse_press_event)
	

	var mouse_release_event = InputEventMouseButton.new()
	mouse_release_event.position = editor.get_local_mouse_position()
	mouse_release_event.global_position = position
	mouse_release_event.button_index = MOUSE_BUTTON_LEFT
	mouse_release_event.pressed = false
	
	Input.parse_input_event(mouse_release_event)
	
#
