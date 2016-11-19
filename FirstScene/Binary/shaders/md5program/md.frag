#version 330 core

in vec3 ourNormal;
in vec2 TexCoord;
out vec4 color;
uniform sampler2D gSampler;

void main()
{
	vec4 tex = texture(gSampler, TexCoord);
	color = tex * vec4(ourNormal, 1.0f);
	color = vec4(ourNormal, 1.0f);
}