extends Control

var myclass
func _on_button_pressed() -> void:
	if ClassDB.class_exists("SwiftGodotAppleTemplate"):
		myclass = ClassDB.instantiate("SwiftGodotAppleTemplate")
		var name = myclass.sayHello($LineEdit.text)
		$result.text = name
	else:
		$result.text = "You do not have the extension installes"
