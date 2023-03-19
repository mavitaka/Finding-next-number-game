extends Control

var numbers = []
var expected_number = 1
var last_number = null
var screen_size = Vector2.ZERO
signal win

func _ready():
	screen_size = get_viewport_rect().size


func start():
	randomize()
	for i in range(1, 101):
		var button = Button.new()
		button.text = str(i)
		button.flat = true
		button.modulate = Color(randi_range(50, 150), randi_range(50, 150), randi_range(50, 150), 255) / 255.0
		button.size = Vector2(25, 25)
		button.add_theme_font_size_override("Xolonium-Regular.ttf", 24)
		add_child(button)
		var button_size = button.get_size()
		var position_found = false
		while not position_found:
			button.position = Vector2(randf_range(0, screen_size.x - button_size.x), randf_range(0, screen_size.y - button_size.y))
			position_found = true
			for number in numbers:
				if button.position.distance_to(number.position) < button_size.x:
					position_found = false
					break
		button.connect("pressed",Callable(self,"_on_button_pressed").bind(button))
		numbers.append(button)

func _on_button_pressed(button):
	if int(button.text) == expected_number:
		button.flat = false
		button.modulate = Color.RED
		if last_number != null:
			last_number.modulate = Color.WHITE
		last_number = button
		expected_number += 1
		if expected_number == 101:
			win.emit()
			#clear_buttons()
			expected_number = 1

func clear_buttons():
	for button in numbers:
		remove_child(button)
	numbers.clear()
