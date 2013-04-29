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
    NSMutableURLRequest  *requestObj;
    NSURLConnection *connection;
    NSMutableData *receivedData;
    NSMutableDictionary *dataDictionary;
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
        // Create the request.
        // create the connection with the request
        // and start loading the data


        fullURL = @"http://shanon.iuii.ua.es/cam2/";
        url = [NSURL URLWithString:fullURL];
        requestObj = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy                                  timeoutInterval:60.0];

        connection = [[NSURLConnection alloc] initWithRequest:requestObj delegate:self];


        if (connection) {
            // Create the NSMutableData to hold the received data.
            // receivedData is an instance variable declared elsewhere.
            receivedData = [NSMutableData data];


        } else {
            // Inform the user that the connection failed.


        }

    }
    return self;
}



// Check for URLConnection failure
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"Error Connection");
    UIAlertView *connectionError = [[UIAlertView alloc] initWithTitle:@"Connection error" message:@"Error connecting to page.  Please check your 3G and/or Wifi settings." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [connectionError show];
    self.hidden = true;
}

-(void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
    //    NSLog(@"did Receive Authentication Challenge");

    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodHTTPBasic])
    {
        NSLog(@"Method HTTP Basic");
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

            // inform the user that the user name and password
            // in the preferences are incorrect

            NSLog (@"failed authentication");
            UIAlertView *connectionError = [[UIAlertView alloc] initWithTitle:@"Authetication error" message:@"Error connecting to page.  User name and password are incorrect." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [connectionError show];
            // ...error will be handled by connection didFailWithError
        }
    }
}



-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    NSLog(@"connectionDidFinishLoading");

}
#pragma mark NSURLConnection Delegate Methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    //    NSLog(@"Connection Did Receive Response");

    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;

    //Check for server error
    if ([httpResponse statusCode] >= 400) {
        UIAlertView *serverError = [[UIAlertView alloc] initWithTitle:@"Server error" message:@"Error connecting to page.  If error persists, please contact support." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [serverError show];
        self.hidden = true;

    } else {

       [self loadData:receivedData MIMEType:@"image/jpeg" textEncodingName:nil baseURL:nil];

        self.hidden = false;
    }
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    //    NSLog(@"3. - Connection didReceiveData");
    if (receivedData == nil) {
        receivedData = [[NSMutableData alloc] init];
    }
    [receivedData appendData:data];
}

#pragma mark - WebView Delegate Methods

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    NSLog(@"didFailLoadWithError: %@", [error description]);
}


- (void)webViewDidFinishLoad:(UIWebView *)webView {
            NSLog(@"2. - WebViewDidFinishLoad");
}

- (void)webViewDidStartLoad:(UIWebView *)webView {

    NSLog(@"1. - WebViewDidStartLoad");


}

@end
