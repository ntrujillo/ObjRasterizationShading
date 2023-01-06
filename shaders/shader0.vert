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

varying vec3 color;

void main()
{
	// transform vPositionModel to world space
	vec3 position = vec3(model * vec4(vPositionModel, 1.0f));

	// transform vNormalModel to  world space
	vec3 normal = normalize(vec3(modelInverseTranspose * vec4(vNormalModel, 1.0f)));

	// compute E
	vec3 eye = vec3(0.0f, 0.0f, 4.0f);
	vec3 E = normalize(eye - position);

	// calculate L
	vec3 L0 = normalize(lights[0].position - position);
	vec3 L1 = normalize(lights[1].position - position);

	// spotlight coeff
	float spotLightCoeff0;
	float spotLightCoeff1;

	if ((dot(-L0, lights[0].A)) < cos(lights[0].theta)) {
		spotLightCoeff0 = 0.0;
	} else {
		spotLightCoeff0 = pow(dot(-L0, lights[0].A), lights[0].alpha);
	}

	if ((dot(-L1, lights[1].A)) < cos(lights[1].theta)) {
		spotLightCoeff1 = 0.0;
	} else {
		spotLightCoeff1 = pow(dot(-L1, lights[1].A), lights[1].alpha);
	}

	// calculate R
	vec3 R0 = normalize(2 * dot(L0, normal) * normal - L0);
	vec3 R1 = normalize(2 * dot(L1, normal) * normal - L1);

	// calculate diffuse
	vec3 diffuse0 = lights[0].color * kd * max(0.0f, dot(L0, normal));
	vec3 diffuse1 = lights[1].color * kd * max(0.0f, dot(L1, normal));

	// calculate specular
	vec3 specular0 = lights[0].color * ks * pow(max(0.0f, dot(R0, E)), s);
	vec3 specular1 = lights[1].color * ks * pow(max(0.0f, dot(R1, E)), s);

	gl_Position = projection * view * model * vec4(vPositionModel, 1.0);

	if (lights[0].spotLight && !lights[1].spotLight) {
		color = ka + diffuse1 + specular1 + (spotLightCoeff0 * (diffuse0 + specular0));
	}

	if (!lights[0].spotLight && lights[1].spotLight) {
		color = ka + diffuse0 + specular0 + (spotLightCoeff1 * (diffuse1 + specular1));
	}

	if (lights[1].spotLight && lights[0].spotLight) {
		color = ka + (spotLightCoeff0 * (diffuse0 + specular0)) + (spotLightCoeff1 * (diffuse1 + specular1));
	}

	if (!lights[1].spotLight && !lights[0].spotLight) {
		color = ka + diffuse1 + specular1 + diffuse0 + specular0;
	}
}
