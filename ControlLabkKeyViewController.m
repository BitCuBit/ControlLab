//
//  ControlLabkKeyViewController.m
//  ControlLab
//
//  Created by Pablo Casado Varela on 30/04/13.
//  Copyright (c) 2013 Pablo Casado Varela. All rights reserved.
//

#import "ControlLabkKeyViewController.h"

@interface ControlLabkKeyViewController (){
    CAGradientLayer *bgLayer;
    UIColor *color;
    UILabel *label1;
    UILabel *label2;
    UILabel *label3;
    UILabel *label4;

}

@end

@implementation ControlLabkKeyViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        // Custom initialization
        NSString *deviceType = [UIDevice currentDevice].model;

        if([deviceType isEqualToString:@"iPhone"]) {
            // For iPhone


            [self.view setBackgroundColor:[UIColor grayColor]];
            color = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:0];

            label3 = [[UILabel alloc ]initWithFrame:CGRectMake(60, 5, 50, 30)];
            [label3 setText:@"Down"];
            [label3 setBackgroundColor:color];
            label3.font = [UIFont fontWithName:@"MarkerFelt-Thin" size: 25.0];
            [label3 setTextAlignment: NSTextAlignmentLeft];

            label4 = [[UILabel alloc ]initWithFrame:CGRectMake(190, 5, 50, 30)];
            [label4 setText:@"Up"];
            [label4 setBackgroundColor:color];
            label4.font = [UIFont fontWithName:@"MarkerFelt-Thin" size: 25.0];
            [label4 setTextAlignment: NSTextAlignmentRight];

            // ADD ELEMENTS TO VIEW
            [self.view addSubview:label3];
            [self.view addSubview:label4];

        }
        else {
            // For iPad
            bgLayer = [ControlLabBackgroundLayer greyGradient];
            bgLayer.frame = self.view.bounds;
            [self.view.layer insertSublayer:bgLayer atIndex:0];


            [self.view setBackgroundColor:[UIColor whiteColor]];
            color = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:0];


            label2 = [[UILabel alloc ]initWithFrame:CGRectMake(50, 10, 200, 30)];
            [label2 setText:@"Blind"];
            [label2 setBackgroundColor:color];
            label2.font = [UIFont fontWithName: @"MarkerFelt-Thin" size: 25.0];
            [label2 setTextAlignment: NSTextAlignmentCenter];

            label3 = [[UILabel alloc ]initWithFrame:CGRectMake(60, 60, 50, 30)];
            [label3 setText:@"Down"];
            [label3 setBackgroundColor:color];
            label3.font = [UIFont fontWithName:@"MarkerFelt-Thin" size: 25.0];
            [label3 setTextAlignment: NSTextAlignmentLeft];

            label4 = [[UILabel alloc ]initWithFrame:CGRectMake(190, 60, 50, 30)];
            [label4 setText:@"Up"];
            [label4 setBackgroundColor:color];
            label4.font = [UIFont fontWithName:@"MarkerFelt-Thin" size: 25.0];
            [label4 setTextAlignment: NSTextAlignmentRight];

            // ADD ELEMENTS TO VIEW
            [self.view addSubview:label2];
            [self.view addSubview:label3];
            [self.view addSubview:label4];
            
        }

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
