//
//  QLPreviewCont.m
//  QLTool
//
//  Created by Tristan Hume on 2014-05-25.
//  Copyright (c) 2014 Tristan Hume. All rights reserved.
//

#import "QLPreviewCont.h"
#import "AppDelegate.h"

@implementation QLPreviewCont

-(id)init
{
    if (self == [super init]) {
        pictures = [[NSMutableArray alloc]init];
        return self;
    }
    return nil;
}

-(void)setPictures:(NSArray*)theArray
{
    [pictures removeAllObjects];
    [pictures setArray:theArray];
}

// Quick Look panel data source
- (NSInteger)numberOfPreviewItemsInPreviewPanel:(QLPreviewPanel *)panel
{
    return [pictures count];
}

- (id <QLPreviewItem>)previewPanel:(QLPreviewPanel *)panel previewItemAtIndex:(NSInteger)index
{
    
    //I’m going to assume that you’ve stored the NSURL’s as strings…
    return [NSURL fileURLWithPath:[pictures objectAtIndex:index]];
}

// Quick Look panel delegate
- (BOOL)previewPanel:(QLPreviewPanel *)panel handleEvent:(NSEvent *)event
{
    AppDelegate *appController = [[NSApplication sharedApplication] delegate];
    // redirect all key down events to the table view
    if ([event type] == NSKeyDown) {
        [appController keyDown:event];
        return YES;
    }
    return NO;
}

@end