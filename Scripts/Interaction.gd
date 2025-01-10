extends Control

signal _buttonPressed
var _isYes

func decision(text):
	toggleDecision()
	$Label.text = text
	yield(self, "_buttonPressed")
	toggleDecision()
	$Label.text = ""


func okButton(text):
	toggleOkButton()
	$Label.text = text
	yield(self, "_buttonPressed")
	toggleOkButton()
	$Label.text = ""


func toggleDecision():
	$yesButton.disabled = !$yesButton.disabled
	$noButton.disabled = !$noButton.disabled
	$yesButton.visible = !$yesButton.visible
	$noButton.visible = !$noButton.visible

func toggleOkButton():
	$okButton.disabled = !$okButton.disabled
	$okButton.visible = !$okButton.visible

func _on_yesButton_pressed():
	_isYes = true
	emit_signal("_buttonPressed")

func _on_noButton_pressed():
	_isYes = false
	emit_signal("_buttonPressed")

func _on_TextureButton_pressed():
	emit_signal("_buttonPressed")

