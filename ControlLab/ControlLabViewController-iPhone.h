//
//  ControlLabViewController-iPhone.h
//  ControlLab
//
//  Created by Pablo Casado Varela on 15/04/13.
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
#import <sys/utsname.h>


#import "Project.h"

// INTERFACES DEVICES
#import "ControlLabkDoorViewController.h"
#import "ControlLabkWindowViewController.h"
#import "ControlLabCustomToolBar.h"
#import "FPPopoverController.h"


@interface ControlLabViewController_iPhone : GLKViewController<GLKViewControllerDelegate,GLKViewDelegate, UIPopoverControllerDelegate,FPPopoverControllerDelegate> {
    GLuint vertexBuffer;
    GLuint indexBuffer[6];
    GLuint colorBuffer;
    GLuint vertexArray;
    FPPopoverController *popover;
}

@property (strong, nonatomic) GLKBaseEffect *baseEffect;
@property (strong, nonatomic) GLKView *glView;

- (void) updateFactor:(float)fact;
- (void) updateFactorUpDown:(float)fact;


@end
