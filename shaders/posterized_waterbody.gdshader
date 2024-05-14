shader_type canvas_item;

group_uniforms Hidden;
uniform float _waterWidth = 0.;
uniform float _ripple_intensity = 0.;
uniform bool _startDrop = false;

group_uniforms Colours;
uniform vec3 _baseColour : source_color;
uniform vec3 _bottomColour : source_color;
uniform float _waterBlending : hint_range(0.0, 10.0, 0.01);

group_uniforms Waves;
uniform vec2 _water_waves_frequency = vec2(0.1,0.05);
uniform vec2 _water_waves_height = vec2(1.,5.);
uniform vec2 _water_waves_speed = vec2(1.,2.);
uniform float _waterDepth = 0.;


uniform float _dropPosition : hint_range(0.0, 1.0, 0.010);

uniform float _pixel_size = 0.1;



#include "res://shaders/corefunctions.gdshaderinc"


void fragment() {
	float posterizedTime = fPosterize(TIME,0.1);
	vec2 _uv = UV;
	_uv.x = fPosterize(_uv.x,_pixel_size);
	_uv.y = fPosterize(_uv.y,_pixel_size);
	
	float scree_adjusted_width = _waterWidth/4.;
	float ripple;
	
	if(_startDrop == true)
	{
		float drop_point = abs(_uv.x/scree_adjusted_width - _dropPosition) * 5.;
		//float ripple_intensity = abs(_uv.x/scree_adjusted_width - _ripple_intensity) * 2.;
		if (drop_point < 1.)
		{
			ripple = mix(sin(((drop_point * 20.) - posterizedTime * 10.)),0.,drop_point);
		}
		ripple *= fSaturate(_ripple_intensity);
	}
	else
	{
		ripple = 0.;
	}
	

	float topClip = _uv.y;
	topClip += (((sin((_uv.x * _water_waves_frequency.x - (_uv.y / 5.)) + (posterizedTime * _water_waves_speed.x))*_water_waves_height.x) +
				(sin((_uv.x * _water_waves_frequency.y) + (posterizedTime * _water_waves_speed.y))*_water_waves_height.y)) - 4.);
				
	topClip += (ripple);


	vec3 waterColour = mix(_baseColour,_bottomColour,vec3(fSaturate((topClip) / _waterBlending)));
	//vec3 waterColour = vec3((fSaturate(topClip) - fSaturate(ripple)) / _waterBlending);
	
	COLOR.xyz =  waterColour / topClip;
	//COLOR.a = round(smoothstep(_waterDepth,0.,topClip)) / round(topClip);
	//COLOR.a = round(topClip - (ripple));
	COLOR.a = round(topClip);

	//COLOR.xyz = vec3();
	
}