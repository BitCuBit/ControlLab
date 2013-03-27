//
//  ControlViewController.h
//  ControlLab
//
//  Created by Pablo Casado Varela on 19/02/13.
//  Copyright (c) 2013 Pablo Casado Varela. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GLKit/GLKit.h>
#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES2/glext.h>
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>
#import <CoreMotion/CoreMotion.h>
#import <QuartzCore/QuartzCore.h>

#import "Project.h"

// INTERFACES DEVICES
#import "ControlLabkDoorViewController.h"
#import "ControlLabkWindowViewController.h"
#import "ControlLabCustomToolBar.h"


@interface ControlViewController : GLKViewController<GLKViewControllerDelegate,GLKViewDelegate, UIPopoverControllerDelegate> {
    GLuint vertexBuffer;
    GLuint indexBuffer[6];
    GLuint colorBuffer;
    GLuint vertexArray;
    UIPopoverController *popover;
}

@property (strong, nonatomic) GLKBaseEffect *baseEffect;
@property (strong, nonatomic) GLKView *glView;

- (void) updateFactor:(float)fact;
- (void) updateFactorUpDown:(float)fact;


@end
