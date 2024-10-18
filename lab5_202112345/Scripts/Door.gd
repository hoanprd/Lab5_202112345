extends Area2D

var winLose_panel: Panel
var winLose_label: Label

func _ready():
	winLose_panel = get_node("../CanvasLayer/UI/WinLosePanel")
	winLose_label = get_node("../CanvasLayer/UI/WinLosePanel/WinLoseLabel")
	winLose_panel.visible = false

func _process(delta):
	if (Global.stopGame && Global.health > 0):
		winLose_panel.visible = true

func _on_body_entered(body: Node2D) -> void:
	if (body.name == "Player"):
		winLose_label.text = "YOU WIN"
		
		Global.stopGame = true
