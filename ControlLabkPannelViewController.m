//
//  ControlLabkPannelViewController.m
//  ControlLab
//
//  Created by Pablo Casado Varela on 13/05/13.
//  Copyright (c) 2013 Pablo Casado Varela. All rights reserved.
//

#import "ControlLabkPannelViewController.h"

@interface ControlLabkPannelViewController () {
        UISwitch *onoff;
        CAGradientLayer *bgLayer;
        UIColor *color;
        UILabel *label1;
        UILabel *label2;
        UILabel *label3;
        UILabel *label4;
        UISlider *slider;
        ControlLabWebViewDevice *aWebView;
        UIButton *buttonUp;
        UIButton *buttonDown;

        NSString *fullURL;
        NSURL *url;
        NSMutableURLRequest  *requestObj;
        NSURLConnection *connection;
        
        int SliderAux;
        
    }

@end

@implementation ControlLabkPannelViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        // Different custom depends of device

        // Custom initialization
        NSString *deviceType = [UIDevice currentDevice].model;

        if([deviceType isEqualToString:@"iPhone"]) {
            // For iPhone


            [self.view setBackgroundColor:[UIColor grayColor]];
            color = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:0];



            onoff = [[UISwitch alloc] initWithFrame: CGRectMake(110, 5, 200, 60)];
            [onoff addTarget: self action: @selector(flip:) forControlEvents:UIControlEventValueChanged];

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

            // WEB VIEW
            aWebView =[[ControlLabWebViewDevice alloc] initWithFrame:CGRectMake(40,50,200,200)];
            // ADD ELEMENTS TO VIEW
            [self.view addSubview:onoff];
            [self.view addSubview:label3];
            [self.view addSubview:label4];
            [self.view addSubview:aWebView];

        }
        else {
            // For iPad
            bgLayer = [ControlLabBackgroundLayer greyGradient];
            bgLayer.frame = self.view.bounds;
            [self.view.layer insertSublayer:bgLayer atIndex:0];

            color = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:0];


            label1 = [[UILabel alloc ]initWithFrame:CGRectMake(50, 10, 200, 30)];
            [label1 setText:@"Pannel"];
            [label1 setBackgroundColor:color];
            label1.font = [UIFont fontWithName: @"MarkerFelt-Thin" size: 25.0];
            [label1 setTextAlignment: NSTextAlignmentCenter];

            // WEB VIEW
            aWebView =[[ControlLabWebViewDevice alloc] initWithFrame:CGRectMake(25,310,250,250)];

            // WHEEL OF COLOR
            colorWheel = [[ISColorWheel alloc] initWithFrame:CGRectMake(25,50,250,250)];
            colorWheel.delegate = self;
            colorWheel.continuous = true;
            [[colorWheel layer] setCornerRadius:10];
            [colorWheel setClipsToBounds:YES];

            [[colorWheel layer] setBorderColor:
             [[UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:1] CGColor]];
            [[colorWheel layer] setBorderWidth:2.75];

            UITapGestureRecognizer *singleFingerTap =
            [[UITapGestureRecognizer alloc] initWithTarget:self
                                                    action:@selector(handleSingleTap:)];
            [colorWheel addGestureRecognizer:singleFingerTap];
            [self.view addSubview:colorWheel];
            // ADD ELEMENTS TO VIEW
            [self.view addSubview:label1];
            [self.view addSubview:aWebView];
        }
        
        
    }
    return self;
}

- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer {
    const CGFloat *components = CGColorGetComponents(colorWheel.currentColor.CGColor);
    CGFloat red = components[0]*254;
    CGFloat green = components[1]*254;
    CGFloat blue = components[2]*254;
    NSLog(@"Red: %.f", red);
    NSLog(@"Green: %.f", green);
    NSLog(@"Blue: %.f", blue);
    fullURL = [NSString stringWithFormat:@"%@/%@/%@/%.f", @"http://shanon.iuii.ua.es/s/rest/home/device", identify, @"write/dimmerRed", red];
    NSLog(@"url: %@", fullURL);
    url = [NSURL URLWithString:fullURL];
    requestObj = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy                                  timeoutInterval:60.0];
    connection = [[NSURLConnection alloc] initWithRequest:requestObj delegate:self];

    fullURL = [NSString stringWithFormat:@"%@/%@/%@/%.f", @"http://shanon.iuii.ua.es/s/rest/home/device", identify, @"write/dimmerGreen", green];
    NSLog(@"url: %@", fullURL);
    url = [NSURL URLWithString:fullURL];
    requestObj = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy                                  timeoutInterval:60.0];
    connection = [[NSURLConnection alloc] initWithRequest:requestObj delegate:self];

    fullURL = [NSString stringWithFormat:@"%@/%@/%@/%.f", @"http://shanon.iuii.ua.es/s/rest/home/device", identify, @"write/dimmerBlue", blue];
    NSLog(@"url: %@", fullURL);
    url = [NSURL URLWithString:fullURL];
    requestObj = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy                                  timeoutInterval:60.0];
    connection = [[NSURLConnection alloc] initWithRequest:requestObj delegate:self];


    //Do stuff here...
}
- (void) getIdentify:(NSString *)device {
    self->identify = device;
    // Envio el Identificador a Web View para que obtenga la camara correcta
    [aWebView getIdDevice:device];
}


- (void)colorWheelDidChangeColor:(ISColorWheel *)colorWhee
{
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
- (void)viewDidDisappear:(BOOL)animated {
    NSLog(@"View Did Disappear");
    [aWebView closeControlLabWebViewDevice];
    [connection cancel];
}

// Check for URLConnection failure
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"Error Connection");
    UIAlertView *connectionError = [[UIAlertView alloc] initWithTitle:@"Connection error" message:@"Error connecting to page.  Please check your 3G and/or Wifi settings." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [connectionError show];
}
-(void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodHTTPBasic])
    {
        if ([challenge previousFailureCount] == 0)
        {
            NSURLCredential *newCredential;
            newCredential = [NSURLCredential credentialWithUser:@"pcasado@dtic.ua.es"
                                                       password:@"b78uxmM33r1"
                                                    persistence:NSURLCredentialPersistenceForSession];
            [[challenge sender] useCredential:newCredential forAuthenticationChallenge:challenge];
        }
        else
        {
            [[challenge sender] cancelAuthenticationChallenge:challenge];

            NSLog (@"failed authentication");
            UIAlertView *connectionError = [[UIAlertView alloc] initWithTitle:@"Authetication error" message:@"Error connecting to page.  User name and password are incorrect." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [connectionError show];
        }
    }
}

@end
