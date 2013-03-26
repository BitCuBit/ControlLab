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

        CAGradientLayer *bgLayer = [ControlLabBackgroundLayer greyGradient];
        bgLayer.frame = self.view.bounds;
        [self.view.layer insertSublayer:bgLayer atIndex:0];

        [self.view setBackgroundColor:[UIColor whiteColor]];

        UIColor *color = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:0];

        UILabel *label1 = [[UILabel alloc ]initWithFrame:CGRectMake(50, 50, 200, 30)];
        [label1 setText:@"Control"];
        [label1 setBackgroundColor:color];
        label1.font = [UIFont fontWithName:@"MarkerFelt-Thin" size: 25.0];
        [label1 setTextAlignment: NSTextAlignmentCenter];

        UILabel *label2 = [[UILabel alloc ]initWithFrame:CGRectMake(50, 100, 200, 30)];
        [label2 setText:@"Blind"];
        [label2 setBackgroundColor:color];
        label2.font = [UIFont fontWithName: @"MarkerFelt-Thin" size: 25.0];
        [label2 setTextAlignment: NSTextAlignmentCenter];

        UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(50, 160, 200, 60)];
        [slider addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventValueChanged];
        slider.minimumValue = 0.0;
        slider.maximumValue = 10.0;
        slider.continuous = YES;

        UILabel *label3 = [[UILabel alloc ]initWithFrame:CGRectMake(60, 150, 50, 30)];
        [label3 setText:@"Up"];
        [label3 setBackgroundColor:color];
        label3.font = [UIFont fontWithName:@"MarkerFelt-Thin" size: 25.0];
        [label3 setTextAlignment: NSTextAlignmentLeft];

        UILabel *label4 = [[UILabel alloc ]initWithFrame:CGRectMake(190, 150, 60, 30)];
        [label4 setText:@"Down"];
        [label4 setBackgroundColor:color];
        label4.font = [UIFont fontWithName:@"MarkerFelt-Thin" size: 25.0];
        [label4 setTextAlignment: NSTextAlignmentRight];

        // WEB VIEW
        ControlLabWebViewDevice *aWebView =[[ControlLabWebViewDevice alloc] initWithFrame:CGRectMake(25,250,250,275)];
        aWebView.delegate = self;

        // ADD ELEMENTS TO VIEW
        [self.view addSubview:label1];
        [self.view addSubview:label2];
        [self.view addSubview:slider];
        [self.view addSubview:label3];
        [self.view addSubview:label4];
        [self.view addSubview:aWebView];

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
