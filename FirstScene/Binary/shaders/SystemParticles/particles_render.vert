#version 330

layout (location = 0)	in	vec3	vPosition;

layout (location = 2)	in	vec3	vColor;
						out	vec3	vColorPass;

layout (location = 3)	in	float	fLifeTime;
						out	float	fLifeTimePass;

layout (location = 4)	in	float	fSize;
						out	float	fSizePass;

layout (location = 5)	in	int		iType;
						out	int		iTypePass;

void main()
{
	gl_Position		=	vec4(vPosition, 1.0);

	vColorPass		=	vColor;
	fSizePass		=	fSize;
	fLifeTimePass	=	fLifeTime;
	iTypePass		=	iType;
}