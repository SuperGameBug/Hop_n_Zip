shader_type canvas_item;
uniform vec3 _baseColour : source_color;
uniform vec3 _bottomColour : source_color;
uniform float _waterClipping : hint_range(0.0, 10.0, 0.01);
uniform vec2 _water_waves_frequency = vec2(0.1,0.05);
uniform vec2 _water_waves_height = vec2(1.,5.);
uniform float _waterDepth = 0.;

uniform float _pixel_size = 0.1;



float fPosterize(float input, float factor )
{
	return round(input/factor) * factor;
}

float fSaturate(float input)
{
	return clamp(input,0.,1.);
}


void fragment() {
	float posterizedTime = fPosterize(TIME,0.1);
	vec2 _uv = UV;
	_uv.x = fPosterize(_uv.x,_pixel_size);
	_uv.y = fPosterize(_uv.y, _pixel_size +.2);
	
	//float topClip = (_uv.y + (sin(_uv.x+TIME) + (sin(_uv.x+TIME*.2)/2.)-4.));
	float topClip = _uv.y;
	topClip += (((sin((_uv.x * _water_waves_frequency.x - (_uv.y / 5.)) + posterizedTime)/_water_waves_height.x) +
				(sin((_uv.x * _water_waves_frequency.y) + posterizedTime)/_water_waves_height.y)) - 4.);


	vec3 waterColour = mix(_baseColour,_bottomColour,vec3(fSaturate(topClip / _waterClipping)));
	COLOR.xyz = waterColour / topClip;
	COLOR.a = fPosterize(smoothstep(_waterDepth,0.,topClip) * fSaturate(topClip), .1);
	//COLOR.a = topClip;

	
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
