//
//  DPBLoginPresenter.m
//  DropboxPub
//
//  Created by Jesus Antonio Gil on 18/11/15.
//  Copyright © 2015 Jesus Antonio Gil. All rights reserved.
//

#import "DPBLoginPresenter.h"

#import <DropboxSDK/DropboxSDK.h>


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
    
}

- (void)loginDropbox
{
    if (![[DBSession sharedSession] isLinked])
    {
        [[DBSession sharedSession] linkFromController:self.viewController];
    }
}

@end
