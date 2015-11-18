//
//  DPBLoginPresenter.m
//  DropboxPub
//
//  Created by Jesus Antonio Gil on 18/11/15.
//  Copyright © 2015 Jesus Antonio Gil. All rights reserved.
//

#import "DPBLoginPresenter.h"


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
    
}

@end
