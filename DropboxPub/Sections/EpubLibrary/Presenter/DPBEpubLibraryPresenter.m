//
//  DPBEpubLibraryPresenter.m
//  DropboxPub
//
//  Created by Jesus Antonio Gil on 18/11/15.
//  Copyright © 2015 Jesus Antonio Gil. All rights reserved.
//

#import "DPBEpubLibraryPresenter.h"
#import "DPBDropboxManager.h"


@interface DPBEpubLibraryPresenter ()

@property (strong, nonatomic) UIViewController<DPBEpubLibraryPresenterDelegate> *viewController;

@end


@implementation DPBEpubLibraryPresenter

- (instancetype)initWithViewController:(UIViewController<DPBEpubLibraryPresenterDelegate> *)viewController
{
    self = [super init];
    if(self)
    {
        self.viewController = viewController;
    }
    
    return self;
}

#pragma mark - PUBLIC

- (void)viewIsReady
{
    
}

- (void)logoutDropboxAccount
{
    [[DPBDropboxManager shared] dropboxUnlinkedAll];
    
    if(![[DPBDropboxManager shared] dropboxIsLinked])
    {
        [self.viewController.navigationController dismissViewControllerAnimated:YES completion:nil];
    }
}

@end
