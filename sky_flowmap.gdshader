shader_type canvas_item;

uniform float speed : hint_range(0.0, 1.0) = 0.4;
uniform float strength : hint_range(0.0, 1.0) = 0.2;

uniform sampler2D sky_texture;
uniform sampler2D flow_texture;
uniform sampler2D noise_texture;

void fragment() {
	float noise = texture(noise_texture, UV).r;
	float time = TIME * speed + noise;
	
	vec2 flow_vectors = (texture(flow_texture, UV).rg - .5) * 2.0;
	float timer1 = fract(time) - .5;
	float timer2 = fract(time + 0.5) - .5;
	float mix_timer = min(fract(time), 1.0 - fract(time)) * 2.0;
	
	vec4 color1 = texture(sky_texture, UV + flow_vectors * timer1 * strength * .1);
	vec4 color2 = texture(sky_texture, UV + flow_vectors * timer2 * strength * .1);
		
	vec4 final_color = mix(color2, color1, mix_timer);
	
	COLOR = final_color;
}