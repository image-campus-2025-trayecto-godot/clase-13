extends PanelContainer

const GAME_SETTINGS_PATH = "user://game_settings.tres"

@onready var music_slider: HSlider = %MusicSlider
@onready var sfx_slider: HSlider = %SfxSlider
@onready var master_slider: HSlider = %MasterSlider
@onready var save_button: Button = %SaveButton

var game_settings: GameSettings

enum AudioBus {
	Master = 0,
	SFX = 1,
	Music = 2
}

func _ready():
	save_button.pressed.connect(save_settings)
	if ResourceLoader.exists(GAME_SETTINGS_PATH):
		game_settings = load(GAME_SETTINGS_PATH)
		apply_settings(game_settings)
	else:
		game_settings = GameSettings.new()
		ResourceSaver.save(game_settings, GAME_SETTINGS_PATH)
	master_slider.value_changed.connect(on_master_slider_value_changed)
	music_slider.value_changed.connect(on_music_slider_value_changed)
	sfx_slider.value_changed.connect(on_sfx_slider_value_changed)
	master_slider.value = AudioServer.get_bus_volume_linear(AudioBus.Master)
	music_slider.value = AudioServer.get_bus_volume_linear(AudioBus.Music)
	sfx_slider.value = AudioServer.get_bus_volume_linear(AudioBus.SFX)

func apply_settings(game_settings: GameSettings):
	AudioServer.set_bus_volume_linear(AudioBus.Master, game_settings.master_volume)
	AudioServer.set_bus_volume_linear(AudioBus.Music, game_settings.music_volume)
	AudioServer.set_bus_volume_linear(AudioBus.SFX, game_settings.sfx_volume)

func on_master_slider_value_changed(new_value):
	AudioServer.set_bus_volume_linear(AudioBus.Master, new_value)
	game_settings.master_volume = new_value

func on_music_slider_value_changed(new_value):
	AudioServer.set_bus_volume_linear(AudioBus.Music, new_value)
	game_settings.music_volume = new_value

func on_sfx_slider_value_changed(new_value):
	AudioServer.set_bus_volume_linear(AudioBus.SFX, new_value)
	game_settings.sfx_volume = new_value

func save_settings():
	print("Saved!")
	ResourceSaver.save(game_settings, GAME_SETTINGS_PATH)
