//
//  ParseManager.h
//  ChattingApp
//
//  Created by Shimaa Essam on 3/16/15.
//  Copyright (c) 2015 Shimaa Essam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@protocol ParseManagerFetchUserPinDelegate;

@interface ParseManager1 : NSObject


@property id<ParseManagerFetchUserPinDelegate> fetchUserdelegate;

+ (ParseManager1*) getInstance;
-(void) fetchUserPin;

@end


@protocol ParseManagerFetchUserPinDelegate <NSObject>
- (void) didFetchUserPinWithObject:(PFObject *)object;
@end