#version 330	core

in	vec4	vColor;
in	vec2	TexCoord;
in	vec3	vNormal;

out	vec4	FragColor;
uniform	sampler2D	gSampler;

void main()
{
	vec4 vTexColor	=	texture(gSampler, TexCoord);
		FragColor	=	vTexColor;
}