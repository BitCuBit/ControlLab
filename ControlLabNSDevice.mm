//
//  ControlLabNSDevice.mm
//  ControlLab
//
//  Created by Pablo Casado Varela on 20/02/13.
//  Copyright (c) 2013 Pablo Casado Varela. All rights reserved.
//

#import "ControlLabNSDevice.h"
#import "Project.h"

static const SceneVertex windowsA [] = {
    {{-1.35f, -0.5f, 4.95f}, { 0.1f, 0.1f, 0.1f, 0.6f}},//0
    {{-1.35f,  2.3f, 4.95f}, { 0.1f, 0.1f, 0.1f, 0.6f}},//1
    {{ 0.2f, -0.5f, 4.95f}, { 0.1f, 0.1f, 0.1f, 0.6f}},//2
    {{ 0.2f,  2.3f, 4.95f}, { 0.1f, 0.1f, 0.1f, 0.6f}} //3
};
static const SceneVertex doorA [] = {
    {{-3.9f, -1.35f, 4.95f}, { 0.1f, 0.1f, 0.1f, 0.6f}},//0
    {{-3.9f,  1.7f, 4.95f}, { 0.1f, 0.1f, 0.1f, 0.6f}},//1
    {{-2.4f, -1.35f, 4.95f}, { 0.1f, 0.1f, 0.1f, 0.6f}},//2
    {{-2.4f,  1.7f, 4.95f}, { 0.1f, 0.1f, 0.1f, 0.6f}} //3
};

@implementation ControlLabNSDevice {



}

- (id) initWithFirstCoordinate:(SceneVertex)firstC andSecond:(SceneVertex)secondC andThird:(SceneVertex)thirdC andFourth:(SceneVertex)fourthC {
    self = [super init];
    if (self) {
        firstCoordinate = firstC;
        secondCoordinate = secondC;
        thirdCoordinate = thirdC;
        fourthCoordinate = fourthC;
    }
    return self;
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
