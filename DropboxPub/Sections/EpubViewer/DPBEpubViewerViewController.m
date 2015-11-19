//
//  DPBEpubViewerViewController.m
//  DropboxPub
//
//  Created by Jesus Antonio Gil on 19/11/15.
//  Copyright © 2015 Jesus Antonio Gil. All rights reserved.
//

#import "DPBEpubViewerViewController.h"
#import "DPBEpubViewerPresenter.h"


@interface DPBEpubViewerViewController () <DPBEpubViewerPresenterDelegate>

@property (strong, nonatomic) DPBEpubViewerPresenter *presenter;

@end


@implementation DPBEpubViewerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.presenter = [[DPBEpubViewerPresenter alloc] initWithViewController:self];
    [self.presenter viewIsReady];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - ACCESSORS

- (IBAction)onCloseButtonTap:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
