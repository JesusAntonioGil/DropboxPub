//
//  DPBEpubLibraryViewController.m
//  DropboxPub
//
//  Created by Jesus Antonio Gil on 18/11/15.
//  Copyright © 2015 Jesus Antonio Gil. All rights reserved.
//

#import "DPBEpubLibraryViewController.h"
#import "DPBEpubLibraryPresenter.h"
#import "DPBEpubLibraryTableViewCell.h"


@interface DPBEpubLibraryViewController () <DPBEpubLibraryPresenterDelegate, UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *segmentedHeightConstraint;
@property (weak, nonatomic) IBOutlet UIButton *logoutButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *logoutHeightConstraint;


@property (strong, nonatomic) DPBEpubLibraryPresenter *presenter;
@property (strong, nonatomic) NSArray *files;

@end


@implementation DPBEpubLibraryViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self customizeView];
    
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
    }
}

#pragma mark - PROTOCOLS & DELEGATES
#pragma mark - Presenter Delegate

- (void)presenterFileList:(NSArray *)files error:(NSError *)error
{
    self.files = files;
    [self.tableView reloadData];
}

#pragma mark - UITableView Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.files.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DPBEpubLibraryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DPBEpubLibraryTableViewCell"];
    if (cell == nil)
    {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"DPBEpubLibraryTableViewCell" owner:self options:nil];
        cell = [topLevelObjects objectAtIndex:0];
    }
    
    cell.metadata = self.files[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    DBMetadata *metadata = self.files[indexPath.row];
    if(metadata.isDirectory)
    {
        [self.presenter pushEpubLibraryWithPathDirectory:metadata.path];
    }
}

@end
