//
//  ControlLabNSDevice.h
//  ControlLab
//
//  Created by Pablo Casado Varela on 20/02/13.
//  Copyright (c) 2013 Pablo Casado Varela. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Project.h"

typedef struct {
    GLfloat position[3];
    GLfloat color[4];
} SceneVertex;

typedef enum {
    kWindows,
    kDoors,
    kLight,
    kPannel
} kDevices;

@interface ControlLabNSDevice : NSObject {
    @public
    SceneVertex firstCoordinate;
    SceneVertex secondCoordinate;
    SceneVertex thirdCoordinate;
    SceneVertex fourthCoordinate;
    NSString *identificador;
    NSString *name;
    kDevices typeOfDevices;
}



- (id) initWithFirstCoordinate:(SceneVertex)firstC andSecond:(SceneVertex)secondC andThird:(SceneVertex)thirdC andFourth:(SceneVertex)fourthC;

- (void) setIdDevice:(NSString *)identify andName:(NSString *)nameDevice andType:(kDevices)type;

- (bool) isSelected:(CGPoint)point withModelview:(float*)modelview andProjection:(float*)projection andViewPort:(int*)viewport;

- (kDevices) getTypeOfDevice;

- (NSString *) getName;

-(NSString *) getIdentificador;

@end
