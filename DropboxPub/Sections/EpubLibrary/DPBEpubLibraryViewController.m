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
#import "DPBEpubLibraryCollectionView.h"


@interface DPBEpubLibraryViewController () <DPBEpubLibraryPresenterDelegate, DPBEpubLibraryTableViewDelegate, DPBEpubLibraryCollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (weak, nonatomic) IBOutlet DPBEpubLibraryTableView *tableView;
@property (weak, nonatomic) IBOutlet DPBEpubLibraryCollectionView *collectionView;
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
    self.collectionView.epubLibraryCollectionViewDelegate = self;
    
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
    [self segmentedControlWithFileShowType:((UISegmentedControl *)sender).selectedSegmentIndex];
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
        self.logoutHeightConstraint.constant = 0.0f;
        self.logoutButton.hidden = YES;
    }
    
    [self segmentedControlWithFileShowType:self.fileShowType];
}

#pragma mark - UIRefreshControl

- (void)addRefreshControlToView
{
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(refreshControlValueChanged) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:self.refreshControl];
    [self.collectionView addSubview:self.refreshControl];
    [self.refreshControl beginRefreshing];
}

- (void)refreshControlValueChanged
{
    [self.presenter getDropboxFileListFromPathDirectory:self.pathDirectory];
}

- (void)sortFileList:(NSArray *)files
{
    NSArray *sortedFiles = [self.presenter sortList:files order:self.fileOrder];
    self.tableView.files = sortedFiles;
    self.collectionView.files = sortedFiles;
    [self.refreshControl endRefreshing];
}

#pragma mark - Segmented Control

- (void)segmentedControlWithFileShowType:(DPBFileShowType)showType
{
    self.fileShowType = showType;
    self.segmentedControl.selectedSegmentIndex = showType;
    
    BOOL fileShowBool = (showType == DPBFileShowTypeTable) ? YES : NO;
    self.collectionView.hidden = fileShowBool;
    self.tableView.hidden = !fileShowBool;
}

#pragma mark - PROTOCOLS & DELEGATES
#pragma mark - Presenter Delegate

- (void)presenterFileList:(NSArray *)files error:(NSError *)error
{
    self.files = files;
    [self sortFileList:files];
}

- (void)presenterOrderList:(NSInteger)order
{
    self.fileOrder = order;
    [self sortFileList:self.files];
}

#pragma mark - DPBEpubLibraryTableView & DPBEpubLibraryCollectionView Delegate

- (void)didSelectMetadata:(DBMetadata *)metadata
{
    if(metadata.isDirectory)
    {
        [self.presenter pushEpubLibraryWithPathDirectory:metadata.path order:self.fileOrder showType:self.fileShowType];
    }
}

@end
