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
        [label2 setText:@"Ventana"];
        [label2 setBackgroundColor:color];
        label2.font = [UIFont fontWithName: @"MarkerFelt-Thin" size: 25.0];
        [label2 setTextAlignment: NSTextAlignmentCenter];

        onoff = [[UISwitch alloc] initWithFrame: CGRectMake(110, 150, 200, 60)];

        [onoff addTarget: self action: @selector(flip:) forControlEvents:UIControlEventValueChanged];

        UILabel *label3 = [[UILabel alloc ]initWithFrame:CGRectMake(60, 150, 50, 30)];
        [label3 setText:@"On"];
        [label3 setBackgroundColor:color];
        label3.font = [UIFont fontWithName:@"MarkerFelt-Thin" size: 25.0];
        [label3 setTextAlignment: NSTextAlignmentLeft];

        UILabel *label4 = [[UILabel alloc ]initWithFrame:CGRectMake(190, 150, 50, 30)];
        [label4 setText:@"Off"];
        [label4 setBackgroundColor:color];
        label4.font = [UIFont fontWithName:@"MarkerFelt-Thin" size: 25.0];
        [label4 setTextAlignment: NSTextAlignmentRight];
        // WEB VIEW
        UIWebView *aWebView =[[UIWebView alloc] initWithFrame:CGRectMake(25,250,250,275)];
        aWebView.delegate = self;
        NSString *fullURL = @"http://web.ua.es/es/dai/dai-virtual-lab.html";
        NSURL *url = [NSURL URLWithString:fullURL];
        NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
        // Round corners using CALayer property
        [[aWebView layer] setCornerRadius:10];
        [aWebView setClipsToBounds:YES];

        // Create colored border using CALayer property
        [[aWebView layer] setBorderColor:
         [[UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:1] CGColor]];
        [[aWebView layer] setBorderWidth:2.75];
        [aWebView loadRequest:requestObj];

        // ADD ELEMENTS TO VIEW
        [self.view addSubview:label1];
        [self.view addSubview:label2];
        [self.view addSubview:onoff];
        [self.view addSubview:label3];
        [self.view addSubview:label4];
        [self.view addSubview:aWebView];

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
