//
//  AppDelegate.m
//  DropboxPub
//
//  Created by Jesus Antonio Gil on 18/11/15.
//  Copyright © 2015 Jesus Antonio Gil. All rights reserved.
//

#import "DPBAppDelegate.h"
#import "DPBStartCoordinator.h"


@interface DPBAppDelegate ()

@property (strong, nonatomic) DPBStartCoordinator *startCoordinator;

@end


@implementation DPBAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //StartCoordinator
    self.startCoordinator = [DPBStartCoordinator new];
    [self.startCoordinator application:application didFinishLaunchingWithOptions:launchOptions];
    
    return YES;
}

#pragma mark - URL

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options
{
    return [self.startCoordinator application:app openURL:url options:options];
}

@end
