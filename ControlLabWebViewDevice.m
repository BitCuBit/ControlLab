//
//  ControlLabWebViewDevice.m
//  ControlLab
//
//  Created by Pablo Casado Varela on 26/03/13.
//  Copyright (c) 2013 Pablo Casado Varela. All rights reserved.
//

#import "ControlLabWebViewDevice.h"

@implementation ControlLabWebViewDevice



- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        NSString *fullURL = @"http://web.ua.es/es/dai/dai-lab.html";
        NSURL *url = [NSURL URLWithString:fullURL];
        NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
        // Round corners using CALayer property
        [[self layer] setCornerRadius:10];
        [self setClipsToBounds:YES];

        // Create colored border using CALayer property
        [[self layer] setBorderColor:
         [[UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:1] CGColor]];
        [[self layer] setBorderWidth:2.75];
        [self loadRequest:requestObj];

    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
