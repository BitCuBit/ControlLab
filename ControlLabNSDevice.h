//
//  ControlLabNSDevice.h
//  ControlLab
//
//  Created by Pablo Casado Varela on 20/02/13.
//  Copyright (c) 2013 Pablo Casado Varela. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ControlLabNSDevice : NSObject


- (bool) isSelected:(CGPoint)point with:(UIInterfaceOrientation *)orientation;

@end
