//
//  ControlLabCustomToolBar.h
//  ControlLab
//
//  Created by Pablo Casado Varela on 27/03/13.
//  Copyright (c) 2013 Pablo Casado Varela. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "ControlLabBackgroundLayer.h"
#import "FPPopoverController.h"
#import "ControlLabkKeyViewController.h"
#import "ControlLabkParamsViewController.h"

@interface ControlLabCustomToolBar : UIToolbar <FPPopoverControllerDelegate>{
    FPPopoverController *popover;

}


@end
