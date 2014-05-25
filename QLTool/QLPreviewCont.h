//
//  QLPreviewCont.h
//  QLTool
//
//  Created by Tristan Hume on 2014-05-25.
//  Copyright (c) 2014 Tristan Hume. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuickLook/QuickLook.h>
#import <QuickLook/QuickLook.h>
#import <Quartz/Quartz.h>

@interface QLPreviewCont : NSResponder <QLPreviewPanelDataSource, QLPreviewPanelDelegate>
{
    NSMutableArray *pictures;
}

-(void)setPictures:(NSArray*)theArray;
-(NSInteger)numberOfPreviewItemsInPreviewPanel:(QLPreviewPanel *)panel;
-(id <QLPreviewItem>)previewPanel:(QLPreviewPanel *)panel previewItemAtIndex:(NSInteger)index;
-(BOOL)previewPanel:(QLPreviewPanel *)panel handleEvent:(NSEvent *)event;

@end
