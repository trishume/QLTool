//
//  AppDelegate.m
//  QLTool
//
//  Created by Tristan Hume on 2014-05-25.
//  Copyright (c) 2014 Tristan Hume. All rights reserved.
//

#import "AppDelegate.h"
#import <QuickLook/QuickLook.h>
#import "ImagePreviewDumper.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    NSArray *arguments = [[NSProcessInfo processInfo] arguments];
    previewFile = [ImagePreviewDumper resolvePath:(arguments[2])];
    [[NSApplication sharedApplication] activateIgnoringOtherApps:YES];
    [self performSelector:@selector(openPanel) withObject:nil afterDelay:0.5];
}

- (void)keyDown:(NSEvent*)event {
    NSLog(@"key");
    if ([QLPreviewPanel sharedPreviewPanelExists] && [[QLPreviewPanel sharedPreviewPanel] isVisible]) {
        [[QLPreviewPanel sharedPreviewPanel] orderOut:nil];
    }
}

- (BOOL)acceptsPreviewPanelControl:(QLPreviewPanel *)panel;
{
    
    // without this method then you can’t set a dataSource or delegate
    return YES;
}

-(void)openPanel
{
    [[QLPreviewPanel sharedPreviewPanel] updateController]; //not sure if this is really needed as it should update itself…
    [[QLPreviewPanel sharedPreviewPanel] makeKeyAndOrderFront:nil];
}

-(void)beginPreviewPanelControl:(QLPreviewPanel *)panel
{
    
    //once you’ve acceepted control then you can set up everything else
    if (!quickLookCont) {
        quickLookCont = [[QLPreviewCont alloc]init];
    }
    [quickLookCont setPictures:@[previewFile]]; //this -getTheSelectedPicturesInTheTable is my method that does just that
    [[QLPreviewPanel sharedPreviewPanel] setDelegate:quickLookCont];
    [[QLPreviewPanel sharedPreviewPanel] setDataSource:quickLookCont];
}

-(void)endPreviewPanelControl:(QLPreviewPanel *)panel
{
    [NSApp terminate:self];
}

@end
