shader_type canvas_item;
render_mode world_vertex_coords;

uniform int scale : hint_range(0,1) = 0;



void fragment() {
	
	vec2 new_UV = UV;
	new_UV.y = (new_UV.y + float(scale)) / 2. ;
	vec4 col = texture(TEXTURE,new_UV);

	COLOR = col;

}
