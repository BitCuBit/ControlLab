//
//  ControlLabWebViewDevice.m
//  ControlLab
//
//  Created by Pablo Casado Varela on 26/03/13.
//  Copyright (c) 2013 Pablo Casado Varela. All rights reserved.
//

#import "ControlLabWebViewDevice.h"

@implementation ControlLabWebViewDevice {
    NSString *fullURL;
    NSURL *url;
    NSURLRequest *requestObj;
}



- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        // Configuration border and window
        self.delegate = self;
        self.scalesPageToFit = YES;
        // Round corners using CALayer property
        [[self layer] setCornerRadius:10];
        [self setClipsToBounds:YES];
        // Create colored border using CALayer property
        [[self layer] setBorderColor:
         [[UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:1] CGColor]];
        [[self layer] setBorderWidth:2.75];

        
        fullURL = @"https://www.dropbox.com/s/l7xlxm9delw88os/web.png";
        url = [NSURL URLWithString:fullURL];
        requestObj = [NSURLRequest requestWithURL:url];
        NSURLConnection *urlConnection = [[NSURLConnection alloc] initWithRequest:requestObj delegate:self];



    }
    return self;
}

// Check for URLConnection failure
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    UIAlertView *connectionError = [[UIAlertView alloc] initWithTitle:@"Connection error" message:@"Error connecting to page.  Please check your 3G and/or Wifi settings." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [connectionError show];
    self.hidden = true;
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {

    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;

    //Check for server error
    if ([httpResponse statusCode] >= 400) {
        UIAlertView *serverError = [[UIAlertView alloc] initWithTitle:@"Server error" message:@"Error connecting to page.  If error persists, please contact support." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [serverError show];
        self.hidden = true;

        //Otherwise load webView
    } else {
        // Redundant code

        [self loadRequest:requestObj];
        self.hidden = false;
    }
}

@end
