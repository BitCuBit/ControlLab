//
//  Project.h
//  ControlLab
//
//  Created by Pablo Casado Varela on 19/02/13.
//  Copyright (c) 2013 Pablo Casado Varela. All rights reserved.
//

#ifndef __ControlLab__Project__
#define __ControlLab__Project__

#include <iostream>
#include <cmath>
#include <OpenGLES/ES2/gl.h>
#include <OpenGLES/ES2/glext.h>

int glhUnProjectf(float winx, float winy, float winz, float *modelview, float *projection, int *viewport, float *objectCoordinate);
int glhProjectf(float objx, float objy, float objz, float *modelview, float *projection, int *viewport, float *windowCoordinate);
void MultiplyMatrices4by4OpenGL_FLOAT(float *result, float *matrix1, float *matrix2);
void MultiplyMatrixByVector4by4OpenGL_FLOAT(float *resultvector, const float *matrix, const float *pvector);
int glhInvertMatrixf2(float *m, float *out);
GLint gluUnProject(GLfloat winx, GLfloat winy, GLfloat winz,
				   const GLfloat model[16], const GLfloat proj[16],
				   const GLint viewport[4],
				   GLfloat * objx, GLfloat * objy, GLfloat * objz);
void transform_point(GLfloat out[4], const GLfloat m[16], const GLfloat in[4]);
void matmul(GLfloat * product, const GLfloat * a, const GLfloat * b);
int invert_matrix(const GLfloat * m, GLfloat * out);
int pointInPolygon (float x, float y, float coord[4][3]);

#endif /* defined(__ControlLab__Project__) */
