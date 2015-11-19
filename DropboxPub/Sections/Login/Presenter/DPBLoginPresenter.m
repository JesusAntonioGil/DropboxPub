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

- (void)presentDropboxLoginViewController
{
    if(![[DPBDropboxManager shared] dropboxIsLinked])
    {
        [[DPBDropboxManager shared] dropboxLinkFromController:self.viewController];
    }
    else
    {
        [self.viewController presenterDropboxLinked:[[DPBDropboxManager shared] dropboxIsLinked]];
    }
}

#pragma mark - PRIVATE

- (void)presentEpubLibraryController
{
    if([[DPBDropboxManager shared] dropboxIsLinked])
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        UINavigationController *epubLibraryNavigationController = [storyboard instantiateViewControllerWithIdentifier:@"DPBEpubLibraryNavigationController"];
        epubLibraryNavigationController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self.viewController presentViewController:epubLibraryNavigationController animated:YES completion:nil];
    }
    else
    {
        [self.viewController presenterDropboxLinked:[[DPBDropboxManager shared] dropboxIsLinked]];
    }
}

@end
