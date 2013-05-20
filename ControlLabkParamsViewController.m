//
//  ControlLabkParamsViewController.m
//  ControlLab
//
//  Created by Pablo Casado Varela on 01/05/13.
//  Copyright (c) 2013 Pablo Casado Varela. All rights reserved.
//

#import "ControlLabkParamsViewController.h"

@interface ControlLabkParamsViewController () {
    CAGradientLayer *bgLayer;
    UIColor *color;
    UILabel *label1;
    UILabel *label2;
    UILabel *label3;
    UILabel *label4;
    UILabel *label5;
    UILabel *label6;
    UISwitch *onoff;
    UISwitch *onoffPan;
    UISlider *slider;

}

@end

@implementation ControlLabkParamsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        // Custom initialization

        [self.view setBounds:CGRectMake(0, 0, 280, 250)];
        // Custom initialization
        NSString *deviceType = [UIDevice currentDevice].model;

        if([deviceType isEqualToString:@"iPhone"]) {
            // For iPhone
            bgLayer = [ControlLabBackgroundLayer greyGradient];
            bgLayer.frame = self.view.bounds;
            [self.view.layer insertSublayer:bgLayer atIndex:0];


            [self.view setBackgroundColor:[UIColor whiteColor]];
            color = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:0];


            label1 = [[UILabel alloc ]initWithFrame:CGRectMake(20, 10, 250, 30)];
            [label1 setText:@"Pan Gesture Factor"];
            [label1 setBackgroundColor:color];
            label1.font = [UIFont fontWithName: @"MarkerFelt-Thin" size: 25.0];
            [label1 setTextAlignment: NSTextAlignmentLeft];

            slider = [[UISlider alloc] initWithFrame:CGRectMake(20, 60, 250, 30)];
            [slider addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventValueChanged];
            [slider setBackgroundColor:[UIColor clearColor]];
            slider.minimumValue = 0.0;
            slider.maximumValue = 50.0;
            slider.continuous = YES;
            slider.value = 25.0;

            
            label2 = [[UILabel alloc ]initWithFrame:CGRectMake(20, 110, 200, 30)];
            [label2 setText:@"Gyroscope"];
            [label2 setBackgroundColor:color];
            label2.font = [UIFont fontWithName:@"MarkerFelt-Thin" size: 25.0];
            [label2 setTextAlignment: NSTextAlignmentLeft];

            onoff = [[UISwitch alloc] initWithFrame: CGRectMake(110, 160, 200, 60)];
            [onoff addTarget: self action: @selector(flip:) forControlEvents:UIControlEventValueChanged];

            label3 = [[UILabel alloc ]initWithFrame:CGRectMake(60, 160, 50, 30)];
            [label3 setText:@"On"];
            [label3 setBackgroundColor:color];
            label3.font = [UIFont fontWithName:@"MarkerFelt-Thin" size: 25.0];
            [label3 setTextAlignment: NSTextAlignmentLeft];

            label4 = [[UILabel alloc ]initWithFrame:CGRectMake(190, 160, 50, 30)];
            [label4 setText:@"Off"];
            [label4 setBackgroundColor:color];
            label4.font = [UIFont fontWithName:@"MarkerFelt-Thin" size: 25.0];
            [label4 setTextAlignment: NSTextAlignmentRight];


            // ADD ELEMENTS TO VIEW
            [self.view addSubview:label1];
            [self.view addSubview:slider];
            [self.view addSubview:label2];
            [self.view addSubview:label3];
            [self.view addSubview:label4];
            [self.view addSubview:onoff];


        }
        else {
            // For iPad
            bgLayer = [ControlLabBackgroundLayer greyGradient];
            bgLayer.frame = self.view.bounds;
            [self.view.layer insertSublayer:bgLayer atIndex:0];


            [self.view setBackgroundColor:[UIColor whiteColor]];
            color = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:0];

            // SWITCH PAN GESTURE


            label1 = [[UILabel alloc ]initWithFrame:CGRectMake(20, 10, 250, 30)];
            [label1 setText:@"Pan Gesture"];
            [label1 setBackgroundColor:color];
            label1.font = [UIFont fontWithName: @"MarkerFelt-Thin" size: 25.0];
            [label1 setTextAlignment: NSTextAlignmentLeft];

            slider = [[UISlider alloc] initWithFrame:CGRectMake(20, 60, 250, 30)];

            NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
            NSNumber *activo;
            if (standardUserDefaults) {
                activo = [[NSNumber alloc] init] ;
                activo = [standardUserDefaults objectForKey:@"panGesture"];

            }

            onoffPan = [[UISwitch alloc] initWithFrame: CGRectMake(110, 60, 200, 60)];
            [onoffPan addTarget: self action: @selector(flipPanGesture:) forControlEvents:UIControlEventValueChanged];

            if ([activo isEqualToNumber:[NSNumber numberWithInt:1]])
                [onoffPan setOn:YES];
            else
                [onoffPan setOn:NO];


            label5 = [[UILabel alloc ]initWithFrame:CGRectMake(60, 60, 50, 30)];
            [label5 setText:@"Off"];
            [label5 setBackgroundColor:color];
            label5.font = [UIFont fontWithName:@"MarkerFelt-Thin" size: 25.0];
            [label5 setTextAlignment: NSTextAlignmentLeft];

            label6 = [[UILabel alloc ]initWithFrame:CGRectMake(190, 60, 50, 30)];
            [label6 setText:@"On"];
            [label6 setBackgroundColor:color];
            label6.font = [UIFont fontWithName:@"MarkerFelt-Thin" size: 25.0];
            [label6 setTextAlignment: NSTextAlignmentRight];


            // SWITCH GYROSCOPE


            label2 = [[UILabel alloc ]initWithFrame:CGRectMake(20, 110, 200, 30)];
            [label2 setText:@"Gyroscope"];
            [label2 setBackgroundColor:color];
            label2.font = [UIFont fontWithName:@"MarkerFelt-Thin" size: 25.0];
            [label2 setTextAlignment: NSTextAlignmentLeft];

            if (standardUserDefaults) {
                activo = [[NSNumber alloc] init] ;
                activo = [standardUserDefaults objectForKey:@"gyroscope"];

            }

            onoff = [[UISwitch alloc] initWithFrame: CGRectMake(110, 160, 200, 60)];
            [onoff addTarget: self action: @selector(flip:) forControlEvents:UIControlEventValueChanged];

            if ([activo isEqualToNumber:[NSNumber numberWithInt:1]])
                [onoff setOn:YES];
            else
                [onoff setOn:NO];


            label3 = [[UILabel alloc ]initWithFrame:CGRectMake(60, 160, 50, 30)];
            [label3 setText:@"Off"];
            [label3 setBackgroundColor:color];
            label3.font = [UIFont fontWithName:@"MarkerFelt-Thin" size: 25.0];
            [label3 setTextAlignment: NSTextAlignmentLeft];

            label4 = [[UILabel alloc ]initWithFrame:CGRectMake(190, 160, 50, 30)];
            [label4 setText:@"On"];
            [label4 setBackgroundColor:color];
            label4.font = [UIFont fontWithName:@"MarkerFelt-Thin" size: 25.0];
            [label4 setTextAlignment: NSTextAlignmentRight];


            // ADD ELEMENTS TO VIEW
            [self.view addSubview:label1];
            [self.view addSubview:label2];
            [self.view addSubview:label3];
            [self.view addSubview:label4];
            [self.view addSubview:label5];
            [self.view addSubview:label6];
            [self.view addSubview:onoff];
            [self.view addSubview:onoffPan];

        }

    }
    return self;
}
- (IBAction)flipPanGesture:(id)sender {
    NSNumber *activo = [[NSNumber alloc] initWithInt:1];

    if (onoffPan.on) {
        NSLog(@"On");
        activo = [[NSNumber alloc] initWithInt:1];
    }
    else {
        NSLog(@"Off");
        activo = [[NSNumber alloc] initWithInt:0];
    }
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];

    if (standardUserDefaults) {
        [standardUserDefaults setObject:activo forKey:@"panGesture"];
        [standardUserDefaults synchronize];
    }
    
}

- (IBAction)flip:(id)sender {
    NSNumber *gyroscope = [[NSNumber alloc] initWithInt:1];

    if (onoff.on) {
        NSLog(@"On");
        gyroscope = [[NSNumber alloc] initWithInt:1];
    }
    else {
        NSLog(@"Off");
        gyroscope = [[NSNumber alloc] initWithInt:0];
    }
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];

    if (standardUserDefaults) {
        [standardUserDefaults setObject:gyroscope forKey:@"gyroscope"];
        [standardUserDefaults synchronize];
    }

}

- (void)pan:(UIPanGestureRecognizer *)gesture {
    NSLog(@"Pan Gesture in View Params");
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    // Añado reconocimiento de arrastre de imagen
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self.view addGestureRecognizer:panGesture];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
