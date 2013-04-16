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

}


- (bool) isSelected:(CGPoint)point with:(UIInterfaceOrientation *)orientation;

@end
