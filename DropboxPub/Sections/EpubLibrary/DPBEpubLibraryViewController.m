//
//  DPBEpubLibraryViewController.m
//  DropboxPub
//
//  Created by Jesus Antonio Gil on 18/11/15.
//  Copyright © 2015 Jesus Antonio Gil. All rights reserved.
//

#import "DPBEpubLibraryViewController.h"
#import "DPBEpubLibraryPresenter.h"


@interface DPBEpubLibraryViewController () <DPBEpubLibraryPresenterDelegate>

@property (strong, nonatomic) DPBEpubLibraryPresenter *presenter;

@end


@implementation DPBEpubLibraryViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.presenter = [[DPBEpubLibraryPresenter alloc] initWithViewController:self];
    [self.presenter viewIsReady];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - PROTOCOLS & DELEGATES

@end
