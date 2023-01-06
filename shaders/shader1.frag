#version 120

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

varying vec3 position;
varying vec3 normal;

void main()
{
	// compute E
	vec3 eye = vec3(0.0f, 0.0f, 4.0f);
	vec3 E = normalize(eye - position);

	// calculate L
	vec3 L0 = normalize(lights[0].position - position);
	vec3 L1 = normalize(lights[1].position - position);

	// calculate R
	vec3 R0 = normalize(2 * dot(L0, normal) * normal - L0);
	vec3 R1 = normalize(2 * dot(L1, normal) * normal - L1);

	// calculate diffuse
	vec3 diffuse0 = lights[0].color * kd * max(0.0f, dot(L0, normal));
	vec3 diffuse1 = lights[1].color * kd * max(0.0f, dot(L1, normal));

	// calculate specular
	vec3 specular0 = lights[0].color * ks * pow(max(0.0f, dot(R0, E)), s);
	vec3 specular1 = lights[1].color * ks * pow(max(0.0f, dot(R1, E)), s);

	gl_FragColor = vec4((ka + diffuse1 + diffuse0 + specular1 + specular0), 1.0f);
}
