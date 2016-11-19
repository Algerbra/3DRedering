#version 330 core

layout (location = 0)	in	vec3	inPosition;
layout (location = 1)	in	vec3	inNormal;
layout (location = 2)	in	vec2	inCoord;
layout (location = 3)	in	vec4	inBoneWeights;
layout (location = 4)	in	vec4	inBoneIndex;


						out	vec2	TexCoord;
						out vec3	vNormal;
uniform	float	xoffset;
uniform	mat4	MVP;
uniform mat4	gBones[100];
void main()
{

			int index		 = int(inBoneIndex[0]);
	mat4	BoneTransform	 =	gBones[index] * inBoneWeights[0];

				index		 = int(inBoneIndex[1]);
			BoneTransform	+=	gBones[index] * inBoneWeights[1];

				index		 = int(inBoneIndex[2]);
			BoneTransform	+=	gBones[index] * inBoneWeights[2];

				index		 = int(inBoneIndex[3]);
			BoneTransform	+=	gBones[index] * inBoneWeights[3];

	vec4	PosLocal	=	BoneTransform * vec4(inPosition, 1.0f);
			
			gl_Position	=	MVP * vec4(PosLocal.xyz, 1.0f);
			TexCoord	=	vec2(inCoord.x, 1.0f- inCoord.y);
			vNormal		=	inNormal;
}