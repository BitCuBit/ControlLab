//
//  ControlLabCustomToolBar.m
//  ControlLab
//
//  Created by Pablo Casado Varela on 27/03/13.
//  Copyright (c) 2013 Pablo Casado Varela. All rights reserved.
//

#import "ControlLabCustomToolBar.h"

@implementation ControlLabCustomToolBar {
    float width;
    float height;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;

        if(orientation == UIInterfaceOrientationPortrait) {
            height = 768;
            width = 1024;
        }
        else if(orientation == UIInterfaceOrientationLandscapeLeft || orientation == UIInterfaceOrientationLandscapeRight) {
            width = 768;
            height = 1024;
            }


        
        self.frame = CGRectMake(0, width - 44, height, 44);
        self.backgroundColor = [UIColor grayColor];

        UIBarButtonItem *flexiableItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
        UIButton *a1 = [UIButton buttonWithType:UIButtonTypeCustom];
        [a1 setFrame:CGRectMake(0.0f, 0.0f, 40.0f, 40.0f)];
        [a1 addTarget:self action:@selector(barbuttomItemActionHouse) forControlEvents:UIControlEventTouchUpInside];
        [a1 setImage:[UIImage imageNamed:@"house.png"] forState:UIControlStateNormal];
        [[a1 layer] setCornerRadius:8.0f];
        [[a1 layer] setMasksToBounds:YES];
        [[a1 layer] setBorderWidth:2.0f];
        UIBarButtonItem *house = [[UIBarButtonItem alloc] initWithCustomView:a1];

        UIButton *a2 = [UIButton buttonWithType:UIButtonTypeCustom];
        [a2 setFrame:CGRectMake(0.0f, 0.0f, 40.0f, 40.0f)];
        [a2 addTarget:self action:@selector(barbuttomItemActionParams) forControlEvents:UIControlEventTouchUpInside];
        [a2 setImage:[UIImage imageNamed:@"params.png"] forState:UIControlStateNormal];
        [[a2 layer] setCornerRadius:8.0f];
        [[a2 layer] setMasksToBounds:YES];
        [[a2 layer] setBorderWidth:2.0f];
        UIBarButtonItem *params = [[UIBarButtonItem alloc] initWithCustomView:a2];

        UIButton *a3 = [UIButton buttonWithType:UIButtonTypeCustom];
        [a3 setFrame:CGRectMake(0.0f, 0.0f, 40.0f, 40.0f)];
        [a3 addTarget:self action:@selector(barbuttomItemActionKey) forControlEvents:UIControlEventTouchUpInside];
        [a3 setImage:[UIImage imageNamed:@"key.png"] forState:UIControlStateNormal];
        [[a3 layer] setCornerRadius:8.0f];
        [[a3 layer] setMasksToBounds:YES];
        [[a3 layer] setBorderWidth:2.0f];
        UIBarButtonItem *key = [[UIBarButtonItem alloc] initWithCustomView:a3];

        UIButton *a4 = [UIButton buttonWithType:UIButtonTypeCustom];
        [a4 setFrame:CGRectMake(0.0f, 0.0f, 40.0f, 40.0f)];
        [a4 addTarget:self action:@selector(barbuttomItemActionExit) forControlEvents:UIControlEventTouchUpInside];
        [a4 setImage:[UIImage imageNamed:@"exit.png"] forState:UIControlStateNormal];
        [[a4 layer] setCornerRadius:8.0f];
        [[a4 layer] setMasksToBounds:YES];
        [[a4 layer] setBorderWidth:2.0f];
        UIBarButtonItem *exit = [[UIBarButtonItem alloc] initWithCustomView:a4];
        
        
        
        NSArray *items = [NSArray arrayWithObjects:house, params, flexiableItem, key, exit,  nil];
        [self setItems:items animated:YES];

    }
    return self;
}


- (void) barbuttomItemActionHouse {
    NSLog(@"Touch Inside House");
}

- (void) barbuttomItemActionParams {
    NSLog(@"Touch Inside Params");
}

- (void) barbuttomItemActionKey {
    NSLog(@"Touch Inside Key");
}

- (void) barbuttomItemActionExit {
    NSLog(@"Touch Inside Exit");
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
