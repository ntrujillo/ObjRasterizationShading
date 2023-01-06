#version 120

varying vec3 normal;

void main()
{
	vec3 eye = vec3(0.0f, 0.0f, 4.0f);

	// if angle between the normal and eye is close to 90◦
	if (dot(eye, normal) < 1.5 && dot(eye, normal) > -1.5 ) {
		// color white
		gl_FragColor = vec4(1.0f, 1.0f, 1.0f, 1.0f);
	} else {
		// color black
		gl_FragColor = vec4(0.0f, 0.0f, 0.0f, 1.0f);
	}
}