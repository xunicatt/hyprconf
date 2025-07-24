//
// Example blue light filter shader.
// 

#version 300 es

precision mediump float;
in vec2 v_texcoord;
uniform sampler2D tex;
out vec4 frag_color;

void main() {

    vec4 pixColor = texture2D(tex, v_texcoord);

    pixColor[2] *= 0.85;

    frag_color = pixColor;
}
