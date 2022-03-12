tool
extends WorldEnvironment

export var sky_texture : ViewportTexture

func _enter_tree() -> void:
	yield(get_tree().create_timer(0.2), "timeout")
	environment.background_sky.set_panorama(sky_texture)
