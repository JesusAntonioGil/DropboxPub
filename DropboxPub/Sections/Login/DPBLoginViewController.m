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

@end


@implementation DPBLoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.presenter = [[DPBLoginPresenter alloc] initWithViewController:self];
    [self.presenter viewIsReady];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - ACTIONS

- (IBAction)onLoginButtonTap:(id)sender
{
    [self.presenter loginDropbox];
}

@end
