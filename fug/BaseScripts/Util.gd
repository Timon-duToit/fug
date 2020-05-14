class_name Util

# Utility funcitons

static func get_animation_time(animator : AnimatedSprite, animation : String) -> float:
	# Returns the total animation time for the currently selected animation
	var frames = animator.frames
	return  frames.get_frame_count(animation) \
			/ frames.get_animation_speed(animation) \
			/ animator.speed_scale
