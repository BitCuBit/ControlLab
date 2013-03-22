//
//  ControlLabNSDevice.mm
//  ControlLab
//
//  Created by Pablo Casado Varela on 20/02/13.
//  Copyright (c) 2013 Pablo Casado Varela. All rights reserved.
//

#import "ControlLabNSDevice.h"
#import "Project.h"

typedef enum {
    kWindows,
    kDoors
} kDevices;

@implementation ControlLabNSDevice {



}

- (bool) isSelected:(CGPoint)point with:(UIInterfaceOrientation)orientation {
    bool selected = false;
    if (orientation == UIInterfaceOrientationPortrait) {

    }
    else if (orientation == UIInterfaceOrientationPortraitUpsideDown) {

    }
    else if (orientation == UIInterfaceOrientationLandscapeLeft) {
        NSLog(@"Landscape Left");
    }
    else if (orientation == UIInterfaceOrientationLandscapeRight) {
    }

    return selected;
}

@end
