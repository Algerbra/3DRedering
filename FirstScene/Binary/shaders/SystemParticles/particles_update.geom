#version 330	core

layout	(points)			in;	//incoming vertices to be treated as points (one-point = one-particle)
layout	(points)			out;//outcoming vertices to be treated as points (one-point = one-particle)
layout	(max_vertices = 40)	out;//hints GPU driver,that maximum amount of emitted vertices will be 40

//"in"	From Reading-Buffer.
//"out"	To	 Writing-Buffer,which will go to next processing stage with TFB
		in	vec3	vPositionPass[];
		out	vec3	vPositionOut;

		in	vec3	vVelocityPass[];
		out	vec3	vVelocityOut;

		in	vec3	vColorPass[];
		out	vec3	vColorOut;

		in	float	fLifeTimePass[];
		out	float	fLifeTimeOut;

		in	float	fSizePass[];
		out	float	fSizeOut;

		in	int		iTypePass[];
		out	int		iTypeOut;

//"uniform"	From CPU-Transferred.
// these uniform variables for controling particle generation..
//
uniform		vec3	vGenPosition;        //position       for newly generated particles
uniform		vec3	vGenVelocityMin;     //min velocity   for newly generated particles
uniform		vec3	vGenVelocityRange;   //range velocity for newly generated particles
uniform		vec3	vGenColor;           //color          for newly generated particles
uniform		vec3	vGenGravityVector;   //gravity        for all particles

uniform		float	fTimePassed;         //time interval between two frame.
uniform		float	fGenLifeMin;         
uniform		float	fGenLifeRange;       
uniform		float	fGenSize;            

uniform		int		iNumToGenerate;      //total number counts of newly generated particles.

uniform		vec3	vRandomSeed;         //seed number for our random number generator function.
			vec3	vLocalSeed;          //serves as a writbale copy of vRandomSeed..


////////////////////////////////////////////////////////////////////////////////////////////////////
//
//
float	randZeroOne()
{
	uint	n	= floatBitsToUint(vLocalSeed.y*214013.0f+vLocalSeed.x*2531011.0f+vLocalSeed.z*141251.0f);
			n	= n * (n * n * 15731u + 789221u);
			n	= (n >> 9u) | 0x3F800000u;

	float	fRes	= 2.0f - uintBitsToFloat(n);
	vLocalSeed.x	= vLocalSeed.x + (147158.0f * fRes);
	vLocalSeed.y	= vLocalSeed.y * fRes + (415161.0f * fRes);
	vLocalSeed.z	= vLocalSeed.z + (324154.0f*fRes);

	return	fRes * 2.5f;
}


////////////////////////////////////////////////////////////////////////////////////////////////////
//
//
#define	Particle_TYPE_Generator	(0)
#define	Particle_TYPE_Normal	(1)
void main()
{
					// gl_Position doesn't matter now
					// as rendering is discarded, so I don't set it at all
	vLocalSeed		= vRandomSeed;

					// updating attributes of particle
	vPositionOut	= vPositionPass[0];
	vVelocityOut	= vVelocityPass[0];

	if (iTypePass[0] != 0) vPositionOut	+= vVelocityOut * fTimePassed;
	if (iTypePass[0] != 0) vVelocityOut	+= vGenGravityVector * fTimePassed * 2.0f;

	vColorOut		= vColorPass[0];				
	fLifeTimeOut	= fLifeTimePass[0] - fTimePassed;
	fSizeOut		= fSizePass[0];					
	iTypeOut		= iTypePass[0];					
	
	if (Particle_TYPE_Generator == iTypePass[0])
	{
		//[Generator_TYPE]
		EmitVertex();
		EndPrimitive();

		for (int i = 0; i < iNumToGenerate; ++i)
		{
			//[Norma_TYPE]Generated and Initialized
			vPositionOut	= vGenPosition;
			vVelocityOut	= vGenVelocityMin;
			vVelocityOut.x += vGenVelocityRange.x * randZeroOne();
			vVelocityOut.y += vGenVelocityRange.y * randZeroOne();
			vVelocityOut.z += vGenVelocityRange.z * randZeroOne();
			vColorOut		= vGenColor;

			fLifeTimeOut	= fGenLifeMin + 3.0f * fGenLifeRange * randZeroOne();
			fSizeOut		= fGenSize;
			iTypeOut		= 1;

			EmitVertex();
			EndPrimitive();
		}
	}

	else
	if ( fLifeTimeOut > 0.0f)
	{
		//Update the ones still alive.
		EmitVertex();
		EndPrimitive();
	}
}
