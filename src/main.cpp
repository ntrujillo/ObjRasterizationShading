#define GLEW_STATIC
#include <GL/glew.h>
#include <GLFW/glfw3.h>
#include <glm/glm.hpp>
#include <glm/gtc/matrix_transform.hpp>
#include <glm/gtc/type_ptr.hpp>
#include <iostream>
#include <string>
#include <fstream>
#include <sstream>
#include <vector>
#include <algorithm>

#include "Program.h"
#define TINYOBJLOADER_IMPLEMENTATION
#include "tiny_obj_loader.h"


#define WINDOW_WIDTH 640
#define WINDOW_HEIGHT 480
#define NUM_LIGHTS 2
#define NUM_MATERIALS 3
#define NUM_SHADERS 3

GLFWwindow *window;

Program program;
bool initialized = false;
int shaderSelection = 0;
std::vector<float> posBuff;
std::vector<float> norBuff;
std::vector<float> texBuff;

glm::vec3 eye(0.0f, 0.0f, 4.0f);

struct materialStruct {
	glm::vec3 ka, kd, ks;
	float s;
} materials[NUM_MATERIALS];
int materialSelection = 0;

struct lightStruct {
	glm::vec3 position;
	glm::vec3 color;
	float theta;
	float alpha;
	glm::vec3 A;
	bool spotLight;
} lights[NUM_LIGHTS];
int lightSelection = 0;

void Display()
{		
	// this process of initialization was used since there were errors with using an array of programs
	if (initialized == false) {
		switch (shaderSelection) {
			case 0: // Gouraud
				program.SetShadersFileName("../shaders/shader0.vert", "../shaders/shader0.frag");
				program.Init();
				break;
			case 1: // Phong
				program.SetShadersFileName("../shaders/shader1.vert", "../shaders/shader1.frag");
				program.Init();
				break;
			case 2: // Silhouette 
				program.SetShadersFileName("../shaders/shader2.vert", "../shaders/shader2.frag");
				program.Init();
				break;
		}
		program.SendAttributeData(posBuff, "vPositionModel");
		program.SendAttributeData(norBuff, "vNormalModel");
		initialized = true;
	}

	int width, height;
	glfwGetFramebufferSize(window, &width, &height);

	glm::mat4 projectionMatrix = glm::perspective(glm::radians(45.0f), float(width) / float(height), 0.1f, 100.0f);
	glm::mat4 viewMatrix = glm::lookAt(eye, glm::vec3(0.0f, 0.0f, 0.0f), glm::vec3(0.0f, 1.0f, 0.0f));

	glm::mat4 modelMatrix(1.0f);
	modelMatrix = glm::translate(glm::mat4(1.0f), glm::vec3(0.2f, -1.0f, 0.0f)) * glm::rotate(glm::mat4(1.0f), glm::radians(45.0f), glm::vec3(0.0f, 1.0f, 0.0f));

	glm::mat4 modelMatrixInverseTranspose = glm::inverse(glm::transpose(modelMatrix));

	program.Bind();
	program.SendUniformData(modelMatrix, "model");
	program.SendUniformData(modelMatrixInverseTranspose, "modelInverseTranspose");
	program.SendUniformData(viewMatrix, "view");
	program.SendUniformData(projectionMatrix, "projection");

	/* send material */
	program.SendUniformData(materials[materialSelection].ka, "ka");
	program.SendUniformData(materials[materialSelection].kd, "kd");
	program.SendUniformData(materials[materialSelection].ks, "ks");
	program.SendUniformData(materials[materialSelection].s, "s");
	
	/* send lights */
	program.SendUniformData(lights[0].position, "lights[0].position");
	program.SendUniformData(lights[0].color, "lights[0].color");
	program.SendUniformData(lights[0].theta, "lights[0].theta");
	program.SendUniformData(lights[0].alpha, "lights[0].alpha");
	program.SendUniformData(lights[0].A, "lights[0].A");
	program.SendUniformData(lights[0].spotLight, "lights[0].spotLight");
	program.SendUniformData(lights[1].position, "lights[1].position");
	program.SendUniformData(lights[1].color, "lights[1].color");
	program.SendUniformData(lights[1].theta, "lights[1].theta");
	program.SendUniformData(lights[1].alpha, "lights[1].alpha");
	program.SendUniformData(lights[1].A, "lights[1].A");
	program.SendUniformData(lights[1].spotLight, "lights[1].spotLight");

	glDrawArrays(GL_TRIANGLES, 0, posBuff.size() / 3);
	program.Unbind();
}

// Keyboard character callback function
void CharacterCallback(GLFWwindow* lWindow, unsigned int key)
{
	switch (key) 
	{
	case 'M':
		if (materialSelection < (NUM_MATERIALS - 1)) {
			materialSelection++;
			std::cout << "material selected: " << materialSelection << std::endl;
		}
		break;

	case 'm':
		if (materialSelection > 0) {
			materialSelection--;
			std::cout << "material selected: " << materialSelection << std::endl;
		}
		break;

	case 'L':
		if (lightSelection < (NUM_LIGHTS - 1)) {
			lightSelection++;
			std::cout << "light selected: " << lightSelection << std::endl;
		}
		break;

	case 'l':
		if (lightSelection > 0) {
			lightSelection--;
			std::cout << "light selected: " << lightSelection << std::endl;
		}
		break;

	case 'X':
		lights[lightSelection].position.x++;
		std::cout << "light " << lightSelection << " xpos: " << lights[lightSelection].position.x << std::endl;
		break;

	case 'x':
		lights[lightSelection].position.x--;
		std::cout << "light " << lightSelection << " xpos: " << lights[lightSelection].position.x << std::endl;
		break;

	case 'Y':
		lights[lightSelection].position.y++;
		std::cout << "light " << lightSelection << " ypos: " << lights[lightSelection].position.y << std::endl;
		break;

	case 'y':
		lights[lightSelection].position.y--;
		std::cout << "light " << lightSelection << " ypos: " << lights[lightSelection].position.y << std::endl;
		break;

	case 'Z':
		lights[lightSelection].position.z++;
		std::cout << "light " << lightSelection << " zpos: " << lights[lightSelection].position.z << std::endl;
		break;

	case 'z':
		lights[lightSelection].position.z--;
		std::cout << "light " << lightSelection << " zpos: " << lights[lightSelection].position.z << std::endl;
		break;

	case 's':
		lights[lightSelection].spotLight = !lights[lightSelection].spotLight;
		std::cout << "light " << lightSelection << " toggle spotlight." << std::endl;
		break;

	case '1':
		shaderSelection = 0;
		std::cout << "Shader Selection: Gouraud" << std::endl;
		initialized = false;
		break;

	case '2':
		shaderSelection = 1;
		std::cout << "Shader Selection: Phong" << std::endl;
		initialized = false;
		break;
	
	case '3':
		shaderSelection = 2;
		std::cout << "Shader Selection: Silhouette" << std::endl;
		initialized = false;
		break;

	case 'q':
		glfwSetWindowShouldClose(window, GLFW_TRUE);
		break;

	default:
		break;
	}
}


void FrameBufferSizeCallback(GLFWwindow* lWindow, int width, int height)
{
	glViewport(0, 0, width, height);
}

void LoadModel(char* name)
{
	// Taken from Shinjiro Sueda with slight modification
	std::string meshName(name);
	tinyobj::attrib_t attrib;
	std::vector<tinyobj::shape_t> shapes;
	std::vector<tinyobj::material_t> materials;
	std::string errStr;
	bool rc = tinyobj::LoadObj(&attrib, &shapes, &materials, &errStr, meshName.c_str());
	if (!rc) {
		std::cerr << errStr << std::endl;
	}
	else {
		// Some OBJ files have different indices for vertex positions, normals,
		// and texture coordinates. For example, a cube corner vertex may have
		// three different normals. Here, we are going to duplicate all such
		// vertices.
		// Loop over shapes
		for (size_t s = 0; s < shapes.size(); s++) {
			// Loop over faces (polygons)
			size_t index_offset = 0;
			for (size_t f = 0; f < shapes[s].mesh.num_face_vertices.size(); f++) {
				size_t fv = shapes[s].mesh.num_face_vertices[f];
				// Loop over vertices in the face.
				for (size_t v = 0; v < fv; v++) {
					// access to vertex
					tinyobj::index_t idx = shapes[s].mesh.indices[index_offset + v];
					posBuff.push_back(attrib.vertices[3 * idx.vertex_index + 0]);
					posBuff.push_back(attrib.vertices[3 * idx.vertex_index + 1]);
					posBuff.push_back(attrib.vertices[3 * idx.vertex_index + 2]);
					if (!attrib.normals.empty()) {
						norBuff.push_back(attrib.normals[3 * idx.normal_index + 0]);
						norBuff.push_back(attrib.normals[3 * idx.normal_index + 1]);
						norBuff.push_back(attrib.normals[3 * idx.normal_index + 2]);
					}
					if (!attrib.texcoords.empty()) {
						texBuff.push_back(attrib.texcoords[2 * idx.texcoord_index + 0]);
						texBuff.push_back(attrib.texcoords[2 * idx.texcoord_index + 1]);
					}
				}
				index_offset += fv;
				// per-face material (IGNORE)
				shapes[s].mesh.material_ids[f];
			}
		}
	}
}

void Init()
{
	glfwInit();
	glfwWindowHint(GLFW_COCOA_RETINA_FRAMEBUFFER, GL_FALSE); // fix for mac resizing
	window = glfwCreateWindow(WINDOW_WIDTH, WINDOW_HEIGHT, "Assignment4 - Nathaniel Trujillo", NULL, NULL);
	glfwMakeContextCurrent(window);
	glewExperimental = GL_TRUE;
	glewInit();
	glViewport(0, 0, WINDOW_WIDTH, WINDOW_HEIGHT);
	glfwSetCharCallback(window, CharacterCallback);
	glfwSetFramebufferSizeCallback(window, FrameBufferSizeCallback);
	glClearColor(0.0f, 0.0f, 0.0f, 0.0f);
	glEnable(GL_DEPTH_TEST);

	LoadModel("../obj/bunny.obj");

	/* populate materials array */

	// material 1
	glm::vec3 ka1 = {0.2f, 0.2f, 0.2f};
	glm::vec3 kd1 = {0.8f, 0.7f, 0.7f};
	glm::vec3 ks1 = {1.0f, 1.0f, 1.0f};
	float s1 = 10.0f;
	materialStruct mat1;
	mat1.ka = ka1;
	mat1.kd = kd1;
	mat1.ks = ks1;
	mat1.s = s1;
	materials[0] = mat1;

	// material 2
	glm::vec3 ka2 = {0.0f, 0.2f, 0.2f};
	glm::vec3 kd2 = {0.5f, 0.7f, 0.2f};
	glm::vec3 ks2 = {0.1f, 1.0f, 0.1f};
	float s2 = 100.0f;
	materialStruct mat2;
	mat2.ka = ka2;
	mat2.kd = kd2;
	mat2.ks = ks2;
	mat2.s = s2;
	materials[1] = mat2;

	// material 3
	glm::vec3 ka3 = {0.2f, 0.2f, 0.2f};
	glm::vec3 kd3 = {0.1f, 0.3f, 0.9f};
	glm::vec3 ks3 = {0.1f, 0.1f, 0.1f};
	float s3 = 1.0f;
	materialStruct mat3;
	mat3.ka = ka3;
	mat3.kd = kd3;
	mat3.ks = ks3;
	mat3.s = s3;
	materials[2] = mat3;

	float theta;
	float alpha;
	glm::vec3 A;
	bool spotLight;

	// light 1
	glm::vec3 lightPos1 = {0.0f, 0.0f, 3.0f};
	glm::vec3 lightColor1 = {0.5f, 0.5f, 0.5f};
	glm::vec3 lightA1 = {0.0, 0.0, -3.0};
	lightStruct light1;
	light1.position = lightPos1;
	light1.color = lightColor1;
	light1.theta = 10;
	light1.alpha = 2;
	light1.A = lightA1;
	light1.spotLight = false;
	lights[0] = light1;

	// light 2
	glm::vec3 lightPos2 = {0.0f, 3.0f, 0.0f};
	glm::vec3 lightColor2 = {0.2f, 0.2f, 0.2f};
	glm::vec3 lightA2 = {0.0, -3.0, 0.0};
	lightStruct light2;
	light2.position = lightPos2;
	light2.color = lightColor2;
	light2.theta = 10;
	light2.alpha = 2;
	light2.A = lightA2;
	light2.spotLight = false;
	lights[1] = light2;
}


int main()
{	
	Init();
	while ( glfwWindowShouldClose(window) == 0) 
	{
		glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
		Display();
		glFlush();
		glfwSwapBuffers(window);
		glfwPollEvents();
	}

	glfwTerminate();
	return 0;
}