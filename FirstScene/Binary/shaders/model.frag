#version	330	core
in	vec3	Normal;
in	vec3	Position;
in	vec2	TexCoords;

out	vec4	color;

uniform	vec3	cameraPos;
uniform	sampler2D	texture_diffuse1;
uniform	sampler2D	texture_reflection1;
uniform	samplerCube	skybox;

void main()
{
	//diffuse
	vec4	diffuse_color	=	texture(texture_diffuse1, TexCoords);

	//reflection
	vec3	Incid	=	normalize(Position - cameraPos);
	vec3	Refle	=	reflect(Incid, normalize(Normal));

	float	reflect_intensity	=	texture(texture_reflection1, TexCoords).r;
	
	vec4	reflect_color;
	if (reflect_intensity > 0.1f)
		reflect_color	=	texture(skybox, Refle) * reflect_intensity;

	color	=	diffuse_color + reflect_color;

}