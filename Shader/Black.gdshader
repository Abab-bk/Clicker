shader_type canvas_item;

uniform float threshold : hint_range(0.0, 1.0, 0.01) = 0.1;

void fragment() {
    vec4 tex_color = texture(TEXTURE, UV);
    float is_black = step(threshold, length(tex_color.rgb));
    COLOR.a = tex_color.a * is_black;
}