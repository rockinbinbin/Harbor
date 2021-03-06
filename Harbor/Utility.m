//
//  Utility.m
//  ChattingApp
//
//  Created by Shimaa Essam on 3/16/15.
//  Copyright (c) 2015 Shimaa Essam. All rights reserved.
//

#import "Utility.h"

@implementation Utility

static Utility *sharedUtility = nil;

+ (Utility*) getInstance{
    @try {
        @synchronized(self)
        {
            if (sharedUtility == nil)
            {
                sharedUtility = [[Utility alloc] init];
            }
        }
        return sharedUtility;
    }
    @catch (NSException *exception) {
    }
}

#pragma mark - progress hud
#pragma mark - Progress Hud Methods
- (void) showProgressHudWithMessage:(NSString*)message withView:(UIView *)view {
    [self showProgressHudWithMessage:message];
}
- (void) showProgressHudWithMessage:(NSString*)message {
    [ProgressHUD dismiss];
    [ProgressHUD show:message Interaction:NO];
}
- (void) hideProgressHud{
  [ProgressHUD dismiss];
}

#pragma mark - Check Internet Reachability
- (BOOL) checkReachabilityAndDisplayErrorMessage{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    [reachability startNotifier];
    NetworkStatus status = [reachability currentReachabilityStatus];
    BOOL ableToConnect = YES;
    
    if(status == NotReachable) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Please check your internet connection."
                                                        message: @""
                                                       delegate: self
                                              cancelButtonTitle: @"OK"
                                              otherButtonTitles: nil];
        [alert show];
        ableToConnect = NO;
    }
    return ableToConnect;
}

#pragma mark - alertview delegate
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        if (![[Utility getInstance] checkReachabilityAndDisplayErrorMessage]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Please check your internet connection"
                                                            message: @""
                                                           delegate: self
                                                  cancelButtonTitle: @"OK"
                                                  otherButtonTitles: nil];
            [alert show];
        }
    }
}

#pragma mark - Show alert view
- (void)showAlertMessage:(NSString *)message
{
    NSLog(@"Method Name %@", [NSString stringWithUTF8String:__func__]);
    @try {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @""
                              message:message
                              delegate:nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil
                              ];
        [alert show];
    }
    @catch (NSException *exception) {
    }
}

-(void) showAlertWithMessage:(NSString*) message andTitle:(NSString*)title{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
}

#pragma mark - Compare request date with current date
- (BOOL)isRequestValid:(NSDate *)craetedDate andTimeAllocated:(NSInteger) time
{
    NSDate *endDate = [craetedDate dateByAddingTimeInterval:time* 60];
    NSDate* currentdate = [NSDate date];
    NSTimeInterval distanceBetweenDates = [endDate timeIntervalSinceDate:currentdate];

    if (distanceBetweenDates <= 0){
        return NO;
    }else{
        return YES;
    }
}
- (BOOL)isRequestValidWithEndDate:(NSDate *)endDate
{
    NSDate* currentdate = [NSDate date];
    NSTimeInterval distanceBetweenDates = [endDate timeIntervalSinceDate:currentdate];
    
    if (distanceBetweenDates <= 0){
        return NO;
    }else{
        return YES;
    }
}

#pragma mark - Create button with action
-(UIButton *)createCustomButton:(UIImage*) buttonImage
{
    UIButton *buttonItem = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonItem.bounds = CGRectMake( 0, 0, buttonImage.size.width, buttonImage.size.height );
    [buttonItem setImage:buttonImage forState:UIControlStateNormal];
    return buttonItem;
}

@end
