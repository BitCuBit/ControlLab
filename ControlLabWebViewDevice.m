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
    NSString *user;
    NSString *pass;

}




- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];

        if (standardUserDefaults) {
            user = [standardUserDefaults objectForKey:@"usuario"];
            pass = [standardUserDefaults objectForKey:@"password"];
            fullURL = [standardUserDefaults objectForKey:@"urlcam2"];
        }
        // Configuration border and window
        // Round corners using CALayer property
        [[self layer] setCornerRadius:10];
        [self setClipsToBounds:YES];
        // Create colored border using CALayer property
        [[self layer] setBorderColor:
         [[UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:1] CGColor]];
        [[self layer] setBorderWidth:2.75];
        // Create the request.



        url = [NSURL URLWithString:fullURL];
        requestObj = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy                                  timeoutInterval:60.0];

        // create the connection with the request
        // and start loading the data
        connection = [[NSURLConnection alloc] initWithRequest:requestObj delegate:self];

        if (connection) {
            receivedData = [NSMutableData data];

        } else {
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
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodHTTPBasic])
    {
        if ([challenge previousFailureCount] == 0)
        {
            NSURLCredential *newCredential;
            newCredential = [NSURLCredential credentialWithUser:user
                                                       password:pass
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
        self.image = [UIImage imageWithData:receivedData];

        [receivedData setLength:0];
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

- (void) closeControlLabWebViewDevice {
    [connection cancel];
}
@end
