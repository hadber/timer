extends Control

@onready var mTimer: Timer = $Timer

# timer setup
@onready var mSetupContainer: VBoxContainer = $Setup

@onready var mButton: Button = $Setup/CenterContainer/VBoxContainer/Button
@onready var mHours: LineEdit = $Setup/CenterContainer/VBoxContainer/HBoxContainer/Hours
@onready var mMinutes: LineEdit = $Setup/CenterContainer/VBoxContainer/HBoxContainer/Minutes
@onready var mSeconds: LineEdit = $Setup/CenterContainer/VBoxContainer/HBoxContainer/Seconds

# timer start
@onready var mProgress: ProgressBar = $ProgressBar
@onready var mCounter: Label = $CenterCounter/Counter

var mCurrentCountdown: float = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mButton.pressed.connect(_on_button_pressed)
	mTimer.timeout.connect(_on_timer_timeout)
	set_setup_mode(true)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if not mTimer.is_stopped():
		mProgress.value = 100 * mTimer.time_left / mCurrentCountdown
		mCounter.text = get_converted_time(mTimer.time_left)
		


func set_setup_mode(enabled: bool) -> void:
	mSetupContainer.visible = enabled
	mCounter.visible = not enabled


func _on_button_pressed() -> void:
	set_setup_mode(false)
	mCurrentCountdown = int(mHours.text) * 3600 + int(mMinutes.text) * 60 + int(mSeconds.text)
	mTimer.start(mCurrentCountdown)


func _on_timer_timeout() -> void:
	set_setup_mode(true)


func get_converted_time(time: float) -> String:
	var hours: int = floori(time / 3600)
	var minutes: int = floori(time / 60)
	var seconds: int = int(time) % 60
	return "%02d:%02d:%02d" % [hours, minutes, seconds]
