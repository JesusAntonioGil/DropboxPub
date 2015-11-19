//
//  DPBEpubViewerPresenter.m
//  DropboxPub
//
//  Created by Jesus Antonio Gil on 19/11/15.
//  Copyright © 2015 Jesus Antonio Gil. All rights reserved.
//

#import "DPBEpubViewerPresenter.h"


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

- (void)viewIsReady
{
    
}

@end
