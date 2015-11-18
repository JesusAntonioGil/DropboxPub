//
//  DPBDropboxManager.h
//  DropboxPub
//
//  Created by Jesus Antonio Gil on 18/11/15.
//  Copyright © 2015 Jesus Antonio Gil. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface DPBDropboxManager : NSObject

+ (DPBDropboxManager *)shared;

//Configure
- (void)initDropboxSession;
- (BOOL)handleOpenURL:(NSURL *)url;

//Login
- (BOOL)dropboxIsLinked;
- (void)dropboxLinkFromController:(UIViewController *)viewController;
- (void)dropboxUnlinkedAll;

@end
