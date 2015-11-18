//
//  DPBLoginPresenter.m
//  DropboxPub
//
//  Created by Jesus Antonio Gil on 18/11/15.
//  Copyright © 2015 Jesus Antonio Gil. All rights reserved.
//

#import "DPBLoginPresenter.h"
#import "DPBDropboxManager.h"


@interface DPBLoginPresenter ()

@property (strong, nonatomic) UIViewController<DPBLoginPresenterDelegate> *viewController;

@end


@implementation DPBLoginPresenter

- (instancetype)initWithViewController:(UIViewController<DPBLoginPresenterDelegate> *)viewController
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
    [self.viewController presenterDropboxLinked:[[DPBDropboxManager shared] dropboxIsLinked]];
}

- (void)presentLoginViewController
{
    if(![[DPBDropboxManager shared] dropboxIsLinked])
    {
        [[DPBDropboxManager shared] dropboxLinkFromController:self.viewController];
    }
}


@end
