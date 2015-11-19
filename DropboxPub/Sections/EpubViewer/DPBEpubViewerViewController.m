//
//  DPBEpubViewerViewController.m
//  DropboxPub
//
//  Created by Jesus Antonio Gil on 19/11/15.
//  Copyright © 2015 Jesus Antonio Gil. All rights reserved.
//

#import "DPBEpubViewerViewController.h"
#import "DPBEpubViewerPresenter.h"

#import <KFEpubKit/KFEpubController.h>
#import <KFEpubContentModel.h>


@interface DPBEpubViewerViewController () <DPBEpubViewerPresenterDelegate , KFEpubControllerDelegate>

@property (strong, nonatomic) DPBEpubViewerPresenter *presenter;
@property (strong, nonatomic) KFEpubController *epubController;
@property (strong, nonatomic) KFEpubContentModel *epubContentModel;
@property (assign, nonatomic) NSUInteger spineIndex;

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end


@implementation DPBEpubViewerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.presenter = [[DPBEpubViewerPresenter alloc] initWithViewController:self];
    [self.presenter viewIsReady];
    [self.presenter downloadFileWithMetadata:self.metadata];
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

#pragma mark - PRIVATE

- (void)createEpubControllerWithLocalPath:(NSString *)localPath
{
    NSURL *epubURL = [NSURL fileURLWithPath:localPath];
    NSURL *documentsURL = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    
    self.epubController = [[KFEpubController alloc] initWithEpubURL:epubURL andDestinationFolder:documentsURL];
    self.epubController.delegate = self;
    [self.epubController openAsynchronous:YES];
}

#pragma mark - Epub content

- (void)updateContentForSpineIndex:(NSUInteger)currentSpineIndex
{
    NSString *contentFile = self.epubContentModel.manifest[self.epubContentModel.spine[currentSpineIndex]][@"href"];
    NSURL *contentURL = [self.epubController.epubContentBaseURL URLByAppendingPathComponent:contentFile];
    NSLog(@"content URL :%@", contentURL);
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:contentURL];
    [self.webView loadRequest:request];
}

#pragma mark - PROTOCOLS & DELEGATES
#pragma mark - Presenter Delegate

- (void)presenterDownloadEpubWithPath:(NSString *)localPath contentType:(NSString *)contentType metadata:(DBMetadata *)metadata error:(NSError *)error
{
    self.metadata = metadata;
    [self createEpubControllerWithLocalPath:localPath];
}

#pragma mark KFEpubControllerDelegate Delegate


- (void)epubController:(KFEpubController *)controller willOpenEpub:(NSURL *)epubURL
{
    NSLog(@"will open epub");
}


- (void)epubController:(KFEpubController *)controller didOpenEpub:(KFEpubContentModel *)contentModel
{
    NSLog(@"opened: %@", contentModel.metaData[@"title"]);
    self.epubContentModel = contentModel;
    self.spineIndex = 4;
    [self updateContentForSpineIndex:self.spineIndex];
}


- (void)epubController:(KFEpubController *)controller didFailWithError:(NSError *)error
{
    NSLog(@"epubController:didFailWithError: %@", error.description);
}

@end
