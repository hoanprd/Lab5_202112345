extends Control

var hurtPanel: Panel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hurtPanel = get_node("HurtPanel")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (Global.getHurt):
		hurtPanel.visible = true
	else:
		hurtPanel.visible = false
