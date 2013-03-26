//
//  ControlLabkWindowViewController.m
//  ControlLab
//
//  Created by Pablo Casado Varela on 26/03/13.
//  Copyright (c) 2013 Pablo Casado Varela. All rights reserved.
//

#import "ControlLabkWindowViewController.h"

@interface ControlLabkWindowViewController () {
    UISwitch *onoff;

}


@end

@implementation ControlLabkWindowViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self.view setBackgroundColor:[UIColor whiteColor]];

        UIColor *color = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:0.3];

        UILabel *label1 = [[UILabel alloc ]initWithFrame:CGRectMake(50, 50, 200, 30)];
        [label1 setText:@"Control"];
        [label1 setBackgroundColor:color];
        label1.font = [UIFont fontWithName:@"Helvetica-Bold" size: 16.0];
        [label1 setTextAlignment: NSTextAlignmentCenter];

        UILabel *label2 = [[UILabel alloc ]initWithFrame:CGRectMake(50, 100, 200, 30)];
        [label2 setText:@"Ventana"];
        [label2 setBackgroundColor:color];
        label2.font = [UIFont fontWithName: @"Helvetica-Bold" size: 16.0];
        [label2 setTextAlignment: NSTextAlignmentCenter];

        onoff = [[UISwitch alloc] initWithFrame: CGRectMake(110, 150, 200, 60)];
        [onoff addTarget: self action: @selector(flip:) forControlEvents:UIControlEventValueChanged];

        UILabel *label3 = [[UILabel alloc ]initWithFrame:CGRectMake(60, 150, 50, 30)];
        [label3 setText:@"On"];
        [label3 setBackgroundColor:[UIColor whiteColor]];
        label3.font = [UIFont fontWithName:@"Helvetica-Bold" size: 16.0];
        [label3 setTextAlignment: NSTextAlignmentLeft];

        UILabel *label4 = [[UILabel alloc ]initWithFrame:CGRectMake(190, 150, 50, 30)];
        [label4 setText:@"Off"];
        [label4 setBackgroundColor:[UIColor whiteColor]];
        label4.font = [UIFont fontWithName:@"Helvetica-Bold" size: 16.0];
        [label4 setTextAlignment: NSTextAlignmentRight];


        [self.view addSubview:label1];
        [self.view addSubview:label2];
        [self.view addSubview:onoff];
        [self.view addSubview:label3];
        [self.view addSubview:label4];

    }
    return self;
}


- (IBAction)flip:(id)sender {
    if (onoff.on) NSLog(@"On");
    else  NSLog(@"Off");
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
