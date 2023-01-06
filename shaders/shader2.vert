#version 120

attribute vec3 vPositionModel; // in object space
attribute vec3 vNormalModel; // in object space

uniform mat4 model;
uniform mat4 modelInverseTranspose;
uniform mat4 view;
uniform mat4 projection;

struct lightStruct {
	vec3 position;
	vec3 color;
	float theta;
	float alpha;
	vec3 A;
	bool spotLight;
};

#define NUM_LIGHTS 2

uniform lightStruct lights[NUM_LIGHTS];

uniform vec3 ka;
uniform vec3 kd;
uniform vec3 ks;
uniform float s;

varying vec3 normal;

void main()
{
	normal = normalize(vec3(modelInverseTranspose * vec4(vNormalModel, 1.0f)));
	gl_Position = projection * view * model * vec4(vPositionModel, 1.0);
}
