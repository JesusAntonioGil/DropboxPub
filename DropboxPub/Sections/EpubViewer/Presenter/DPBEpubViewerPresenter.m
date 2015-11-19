//
//  DPBEpubViewerPresenter.m
//  DropboxPub
//
//  Created by Jesus Antonio Gil on 19/11/15.
//  Copyright © 2015 Jesus Antonio Gil. All rights reserved.
//

#import "DPBEpubViewerPresenter.h"
#import "DPBDropboxManager.h"


@interface DPBEpubViewerPresenter ()

@property (strong, nonatomic) UIViewController<DPBEpubViewerPresenterDelegate> *viewController;

@end


@implementation DPBEpubViewerPresenter

- (instancetype)initWithViewController:(UIViewController<DPBEpubViewerPresenterDelegate> *)viewController
{
    self = [super init];
    if(self)
    {
        self.viewController = viewController;
    }
    
    return self;
}

#pragma mark - PUBLIC

- (void)downloadFileWithMetadata:(DBMetadata *)metadata
{
    __weak typeof(self) weakSelf = self;
    [[DPBDropboxManager shared] downloadFileWithPath:metadata.path completion:^(NSString *localPath, NSString *contentType, DBMetadata *metadata, NSError *error) {
        __strong typeof(self) strongSelf = weakSelf;
        [strongSelf.viewController presenterDownloadEpubWithPath:localPath contentType:contentType metadata:metadata error:error];
    }];
}

@end
