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

@property (strong, nonatomic) DPBEpubLibraryPresenter *presenter;
@property (strong, nonatomic) NSArray *epubs;

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

#pragma mark - ACTIONS

- (IBAction)onLogoutButtonTap:(id)sender
{
    [self.presenter logoutDropboxAccount];
}

- (IBAction)onSegmentedControlValueChanged:(id)sender
{
    NSLog(@"AQUI");
}

#pragma mark - PROTOCOLS & DELEGATES
#pragma mark - Presenter Delegate

- (void)presenterEpubLibraryList:(NSArray *)epubs error:(NSError *)error
{
    self.epubs = epubs;
    [self.tableView reloadData];
}

#pragma mark - UITableView Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.epubs.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DPBEpubLibraryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DPBEpubLibraryTableViewCell"];
    if (cell == nil)
    {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"DPBEpubLibraryTableViewCell" owner:self options:nil];
        cell = [topLevelObjects objectAtIndex:0];
    }
    
    cell.metadata = self.epubs[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
