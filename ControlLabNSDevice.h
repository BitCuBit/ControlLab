//
//  ControlLabNSDevice.h
//  ControlLab
//
//  Created by Pablo Casado Varela on 20/02/13.
//  Copyright (c) 2013 Pablo Casado Varela. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef struct {
    GLfloat position[3];
    GLfloat color[4];
} SceneVertex;

typedef enum {
    kWindows,
    kDoors
} kDevices;

@interface ControlLabNSDevice : NSObject {
    SceneVertex firstCoordinate;
    SceneVertex secondCoordinate;
    SceneVertex thirdCoordinate;
    SceneVertex fourthCoordinate;
}

- (id) initWithFirstCoordinate:(SceneVertex)firstC andSecond:(SceneVertex)secondC andThird:(SceneVertex)thirdC andFourth:(SceneVertex)fourthC;
- (bool) isSelected:(CGPoint)point with:(UIInterfaceOrientation)orientation;

@end
