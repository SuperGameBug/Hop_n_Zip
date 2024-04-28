shader_type canvas_item;

uniform int _frame = 0;
uniform float _spriteLength = 1.;
uniform bool _isAnimSprite = false;



void fragment() {
	
	vec2 new_UV = UV;
	if(_isAnimSprite == true)
	{
		new_UV.x = (new_UV.x + float(_frame))/ _spriteLength;
	}
	else
	{
		new_UV.y = (new_UV.y + float(_frame)) / _spriteLength ;
	}
	vec4 col = texture(TEXTURE,new_UV);

	COLOR = col;

}
