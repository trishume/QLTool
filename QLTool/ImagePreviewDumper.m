//
//  ImagePreviewDumper.m
//  QLTool
//
//  Created by Tristan Hume on 2014-05-25.
//  Copyright (c) 2014 Tristan Hume. All rights reserved.
//

#import "ImagePreviewDumper.h"
#import "NSImage+QuickLook.h"
#import "MF_Base64Additions.h"
#import "stdlib.h"

@implementation ImagePreviewDumper

+ (NSString *)resolvePath:(NSString *)path {
    NSString *expandedPath = [path stringByStandardizingPath];
    const char *cpath = [expandedPath cStringUsingEncoding:NSUTF8StringEncoding];
    char *resolved = NULL;
    char *returnValue = realpath(cpath, resolved);
    
    if (returnValue == NULL && resolved != NULL) {
        printf("Error with path: %s\n", resolved);
        // if there is an error then resolved is set with the path which caused the issue
        // returning nil will prevent further action on this path
        return nil;
    }
    
    return [NSString stringWithCString:returnValue encoding:NSUTF8StringEncoding];
}

+ (NSData *)PNGRepresentationOfImage:(NSImage *) image {
    // Create a bitmap representation from the current image
    
    [image lockFocus];
    NSBitmapImageRep *bitmapRep = [[NSBitmapImageRep alloc] initWithFocusedViewRect:NSMakeRect(0, 0, image.size.width, image.size.height)];
    [image unlockFocus];
    
    return [bitmapRep representationUsingType:NSPNGFileType properties:Nil];
}

+ (NSString*)base64ImageData:(NSImage*)image {
    NSData *data = [ImagePreviewDumper PNGRepresentationOfImage:image];
    return [data base64String];
}

+ (NSString*)dataPreviewFor:(NSString*)path ofSize:(NSSize)size asIcon:(BOOL)icon {
    NSString *absPath = [ImagePreviewDumper resolvePath:path];
    NSImage *img = [NSImage imageWithPreviewOfFileAtPath:absPath ofSize:size asIcon:icon];
    return [ImagePreviewDumper base64ImageData:img];
}

+ (NSString*)terminalPreviewFor:(NSString*)path ofSize:(NSSize)size asIcon:(BOOL)icon {
    NSString *base64 = [ImagePreviewDumper dataPreviewFor:path ofSize:size asIcon:icon];
    NSString *path64 = [path base64String];
    NSUInteger datSize = [base64 length];
    NSString *str = [NSString stringWithFormat:@"\033]1337;File=name=%@;size=%lu;inline=1:%@\a\n",
                     path64, (unsigned long)datSize, base64];
    return str;
}

@end
