//
//  DPBEpubLibraryViewController.m
//  DropboxPub
//
//  Created by Jesus Antonio Gil on 18/11/15.
//  Copyright © 2015 Jesus Antonio Gil. All rights reserved.
//

#import "DPBEpubLibraryViewController.h"
#import "DPBEpubLibraryPresenter.h"
#import "DPBEpubLibraryTableView.h"
#import "DPBEpubLibraryTableViewCell.h"


@interface DPBEpubLibraryViewController () <DPBEpubLibraryPresenterDelegate, DPBEpubLibraryTableViewDelegate>

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (weak, nonatomic) IBOutlet DPBEpubLibraryTableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *listButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *segmentedHeightConstraint;
@property (weak, nonatomic) IBOutlet UIButton *logoutButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *logoutHeightConstraint;

@property (strong, nonatomic) DPBEpubLibraryPresenter *presenter;
@property (strong, nonatomic) NSArray *files;
@property (strong, nonatomic) UIRefreshControl *refreshControl;

@end


@implementation DPBEpubLibraryViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self customizeView];
    [self addRefreshControlToView];
    self.tableView.epubLibraryTableViewDelegate = self;
    
    self.presenter = [[DPBEpubLibraryPresenter alloc] initWithViewController:self];
    self.presenter.pathDirectory = self.pathDirectory;
    [self.presenter viewIsReady];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - ACCESSORS

- (NSString *)pathDirectory
{
    if(!_pathDirectory)
    {
        _pathDirectory = @"/";
    }
    
    return _pathDirectory;
}

#pragma mark - ACTIONS

- (IBAction)onLogoutButtonTap:(id)sender
{
    [self.presenter logoutDropboxAccount];
}

- (IBAction)onSegmentedControlValueChanged:(id)sender
{
    NSLog(@"AQUI");
}

- (IBAction)onListButtonTap:(id)sender
{
    [self.presenter showOrderActionController];
}

#pragma mark - PRIVATE

- (void)customizeView
{
    self.title = [self.pathDirectory getFolderName];
    
    if(self.navigationController.viewControllers.firstObject != self)
    {
        self.segmentedHeightConstraint.constant = 0.0f;
        self.segmentedControl.hidden = YES;
        self.logoutHeightConstraint.constant = 0.0f;
        self.logoutButton.hidden = YES;
        self.listButton.hidden = YES;
    }
}

#pragma mark - UIRefreshControl

- (void)addRefreshControlToView
{
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(refreshControlValueChanged) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:self.refreshControl];
    [self.refreshControl beginRefreshing];
}

- (void)refreshControlValueChanged
{
    [self.presenter getDropboxFileListFromPathDirectory:self.pathDirectory];
}

- (void)sortFileList:(NSArray *)files
{
    self.tableView.files = [self.presenter sortList:files order:self.fileOrder];
    [self.refreshControl endRefreshing];
}

#pragma mark - PROTOCOLS & DELEGATES
#pragma mark - Presenter Delegate

- (void)presenterFileList:(NSArray *)files error:(NSError *)error
{
    [self sortFileList:files];
}

- (void)presenterOrderList:(NSInteger)order
{
    self.fileOrder = order;
    [self sortFileList:self.files];
}

#pragma mark - DPBEpubLibraryTableView Delegate

- (void)didSelectMetadata:(DBMetadata *)metadata
{
    if(metadata.isDirectory)
    {
        [self.presenter pushEpubLibraryWithPathDirectory:metadata.path order:self.fileOrder];
    }
}

@end
