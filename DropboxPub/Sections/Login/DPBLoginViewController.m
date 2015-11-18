//
//  DPBLoginViewController.m
//  DropboxPub
//
//  Created by Jesus Antonio Gil on 18/11/15.
//  Copyright © 2015 Jesus Antonio Gil. All rights reserved.
//

#import "DPBLoginViewController.h"
#import "DPBLoginPresenter.h"


@interface DPBLoginViewController () <DPBLoginPresenterDelegate>

@property (strong, nonatomic) DPBLoginPresenter *presenter;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end


@implementation DPBLoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.presenter viewIsReady];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - ACCESSORS

- (DPBLoginPresenter *)presenter
{
    if(!_presenter)
    {
        self.presenter = [[DPBLoginPresenter alloc] initWithViewController:self];
    }
    
    return _presenter;
}

#pragma mark - ACTIONS

- (IBAction)onLoginButtonTap:(id)sender
{
    [self.presenter presentDropboxLoginViewController];
}

#pragma mark - PRIVATE

- (void)dropboxLinked:(BOOL)linked
{
    self.activityIndicator.hidden = !linked;
    self.loginButton.hidden = linked;
    
    if(linked) [self.presenter presentEpubLibraryController];
}

#pragma mark - PROTOCOLS & DELEGATES
#pragma mark - Presenter Delegate

- (void)presenterDropboxLinked:(BOOL)linked
{
    [self dropboxLinked:linked];
}

@end
