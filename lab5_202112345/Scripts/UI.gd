extends Control

var hurtPanel: Panel
var exitGameTimer: Timer
var gameOver: bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hurtPanel = get_node("HurtPanel")
	exitGameTimer = get_node("ExitGameTimer")
	gameOver = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (Global.getHurt):
		hurtPanel.visible = true
	else:
		hurtPanel.visible = false
	
	if (Global.health <= 0 || Global.stopGame):
		if (!gameOver):
			gameOver = true
			exitGameTimer.start()


func _on_exit_game_timer_timeout() -> void:
	get_tree().quit()
