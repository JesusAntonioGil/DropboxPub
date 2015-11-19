//
//  DPBDropboxManager.h
//  DropboxPub
//
//  Created by Jesus Antonio Gil on 18/11/15.
//  Copyright © 2015 Jesus Antonio Gil. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <DropboxSDK/DropboxSDK.h>


typedef void (^DPBDropboxManagerFilesCompletion)(NSArray *files, NSError *error);
typedef void (^DPBDropboxManagerDownloadFileCompletion)(NSString *localPath, NSString *contentType, DBMetadata *metadata, NSError *error);

@interface DPBDropboxManager : NSObject

+ (DPBDropboxManager *)shared;

//Configure
- (void)initDropboxSession;
- (BOOL)handleOpenURL:(NSURL *)url;

//Login
- (BOOL)dropboxIsLinked;
- (void)dropboxLinkFromController:(UIViewController *)viewController;
- (void)dropboxUnlinkedAll;

//Files
- (void)loadFilesWithPathDirectory:(NSString *)pathDirectory completion:(DPBDropboxManagerFilesCompletion)completion;
- (void)downloadFileWithPath:(NSString *)filePath completion:(DPBDropboxManagerDownloadFileCompletion)completion;

@end
