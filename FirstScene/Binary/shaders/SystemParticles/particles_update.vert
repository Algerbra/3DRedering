#version 330

layout (location = 0)	in	vec3	vPosition;
						out vec3	vPositionPass;

layout (location = 1)	in	vec3	vVelocity;
						out vec3	vVelocityPass;

layout (location = 2)	in	vec3	vColor;
						out vec3	vColorPass;

layout (location = 3)	in	float	fLifeTime;
						out float	fLifeTimePass;

layout (location = 4)	in	float	fSize;
						out float	fSizePass;

layout (location = 5)	in	int		iType;
						out int		iTypePass;

void main()
{
	  vPositionPass = vPosition;
	  vVelocityPass = vVelocity;
	  vColorPass	= vColor;
	  fLifeTimePass = fLifeTime;
	  fSizePass		= fSize;
	  iTypePass		= iType;
}