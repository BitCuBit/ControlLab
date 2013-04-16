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
    CAGradientLayer *bgLayer;
    UIColor *color;
    UILabel *label1;
    UILabel *label2;
    UILabel *label3;
    UILabel *label4;
    UISlider *slider;
    ControlLabWebViewDevice *aWebView;


}


@end

@implementation ControlLabkWindowViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        // Different custom depends of device

        NSString *deviceType = [UIDevice currentDevice].model;

        if([deviceType isEqualToString:@"iPhone"]) {


            [self.view setBackgroundColor:[UIColor grayColor]];

            color = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:0];

            label2 = [[UILabel alloc ]initWithFrame:CGRectMake(0, 5, 200, 30)];
            [label2 setText:@"Blind"];
            [label2 setBackgroundColor:color];
            label2.font = [UIFont fontWithName: @"MarkerFelt-Thin" size: 25.0];
            [label2 setTextAlignment: NSTextAlignmentLeft];

            slider = [[UISlider alloc] initWithFrame:CGRectMake(70, 5, 140, 60)];
            [slider addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventValueChanged];
            slider.minimumValue = 0.0;
            slider.maximumValue = 10.0;
            slider.continuous = YES;

            label3 = [[UILabel alloc ]initWithFrame:CGRectMake(10, 15, 30, 30)];
            [label3 setText:@"Up"];
            [label3 setBackgroundColor:color];
            label3.font = [UIFont fontWithName:@"MarkerFelt-Thin" size: 25.0];
            [label3 setTextAlignment: NSTextAlignmentCenter];

            label4 = [[UILabel alloc ]initWithFrame:CGRectMake(215, 15, 60, 30)];
            [label4 setText:@"Down"];
            [label4 setBackgroundColor:color];
            label4.font = [UIFont fontWithName:@"MarkerFelt-Thin" size: 25.0];
            [label4 setTextAlignment: NSTextAlignmentRight];
            // WEB VIEW
            aWebView =[[ControlLabWebViewDevice alloc] initWithFrame:CGRectMake(40,50,200,200)];
            // ADD ELEMENTS TO VIEW

            //            [self.view addSubview:label2];
            [self.view addSubview:slider];
            [self.view addSubview:label3];
            [self.view addSubview:label4];
            [self.view addSubview:aWebView];


        }
        else {
            bgLayer = [ControlLabBackgroundLayer greyGradient];
            bgLayer.frame = self.view.bounds;
            [self.view.layer insertSublayer:bgLayer atIndex:0];

            color = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:0];


            label2 = [[UILabel alloc ]initWithFrame:CGRectMake(50, 10, 200, 30)];
            [label2 setText:@"Ventana"];
            [label2 setBackgroundColor:color];
            label2.font = [UIFont fontWithName: @"MarkerFelt-Thin" size: 25.0];
            [label2 setTextAlignment: NSTextAlignmentCenter];

            slider = [[UISlider alloc] initWithFrame:CGRectMake(50, 60, 200, 60)];
            [slider addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventValueChanged];
            slider.minimumValue = 0.0;
            slider.maximumValue = 10.0;
            slider.continuous = YES;

            label3 = [[UILabel alloc ]initWithFrame:CGRectMake(60, 50, 50, 30)];
            [label3 setText:@"Up"];
            [label3 setBackgroundColor:color];
            label3.font = [UIFont fontWithName:@"MarkerFelt-Thin" size: 25.0];
            [label3 setTextAlignment: NSTextAlignmentLeft];

            label4 = [[UILabel alloc ]initWithFrame:CGRectMake(190, 50, 60, 30)];
            [label4 setText:@"Down"];
            [label4 setBackgroundColor:color];
            label4.font = [UIFont fontWithName:@"MarkerFelt-Thin" size: 25.0];
            [label4 setTextAlignment: NSTextAlignmentRight];
            
            // WEB VIEW
            aWebView =[[ControlLabWebViewDevice alloc] initWithFrame:CGRectMake(25,110,250,250)];
            // ADD ELEMENTS TO VIEW

            [self.view addSubview:label2];
            [self.view addSubview:slider];
            [self.view addSubview:label3];
            [self.view addSubview:label4];
            [self.view addSubview:aWebView];


        }


    }
    return self;
}

- (IBAction)sliderAction:(id)sender{
    UISlider *MYslider = (UISlider *)sender;
    int SliderValue = (int)roundf(MYslider.value);
    NSLog(@"Valor Slider: %d", SliderValue);
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
