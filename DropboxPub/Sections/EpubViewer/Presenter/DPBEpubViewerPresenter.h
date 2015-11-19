//
//  DPBEpubViewerPresenter.h
//  DropboxPub
//
//  Created by Jesus Antonio Gil on 19/11/15.
//  Copyright © 2015 Jesus Antonio Gil. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <DropboxSDK/DBMetadata.h>


@protocol DPBEpubViewerPresenterDelegate <NSObject>

- (void)presenterDownloadEpubWithPath:(NSString *)localPath contentType:(NSString *)contentType metadata:(DBMetadata *)metadata error:(NSError *)error;

@end


@interface DPBEpubViewerPresenter : NSObject

- (instancetype)initWithViewController:(UIViewController<DPBEpubViewerPresenterDelegate> *)viewController;
- (void)downloadFileWithMetadata:(DBMetadata *)metadata;

@end
