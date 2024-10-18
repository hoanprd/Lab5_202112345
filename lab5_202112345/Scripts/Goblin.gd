extends Area2D

var timer: Timer
var hurtTimer: Timer

func _ready():
	hurtTimer = get_node("HurtTimer")
	timer = get_node("Timer")

func _on_body_entered(body: Node2D) -> void:
	if (body.name == "Player" && Global.health <= 100 && Global.health > 0):
		Global.health -= 10
		Global.getHurt = true
		hurtTimer.start()
		timer.start()


func _on_timer_timeout() -> void:
	if (Global.health <= 100 && Global.health > 0):
		Global.health -= 10
		Global.getHurt = true
		hurtTimer.start()
	else:
		timer.stop()


func _on_body_exited(body: Node2D) -> void:
	if (body.name == "Player" && Global.health <= 100):
		Global.getHurt = false
		hurtTimer.stop()
		timer.stop()


func _on_hurt_timer_timeout() -> void:
	Global.getHurt = false
