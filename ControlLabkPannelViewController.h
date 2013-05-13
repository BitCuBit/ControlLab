//
//  ControlLabkPannelViewController.h
//  ControlLab
//
//  Created by Pablo Casado Varela on 13/05/13.
//  Copyright (c) 2013 Pablo Casado Varela. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "ControlLabBackgroundLayer.h"
#import "ControlLabWebViewDevice.h"


@interface ControlLabkPannelViewController : UIViewController<NSURLConnectionDelegate> {
    NSString *identify;
}
- (void) getIdentify:(NSString *)device;

@end
