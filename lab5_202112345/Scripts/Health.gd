extends Area2D

var targetPos
var label
var healthAmount = 50

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	targetPos = get_tree().current_scene.get_node("CanvasLayer/UI").global_position
	label = get_tree().current_scene.get_node("CanvasLayer/UI")

func _on_body_entered(body: Node2D) -> void:
	if (body.name == "Player"):
		if (Global.health < 100):
			if (Global.health + healthAmount > 100):
				Global.health = 100
			else:
				Global.health += healthAmount
		var tween = get_tree().create_tween()
		tween.tween_property(self, "global_position", targetPos, 0.5).set_ease(Tween.EASE_IN)
		tween.chain().tween_property(self, "visible", false, 0.0)
		tween.tween_property(label, "scale", Vector2(1.1,1.1), 0.05)
		tween.chain().tween_property(label, "scale", Vector2(1.0,1.0), 0.05)
		tween.chain().tween_callback(queue_free)
