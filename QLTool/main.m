//
//  main.m
//  QLTool
//
//  Created by Tristan Hume on 2014-05-25.
//  Copyright (c) 2014 Tristan Hume. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "stdio.h"
#import "ImagePreviewDumper.h"

int main(int argc, const char * argv[])
{
    //NSLog(@"%s", argv[0]);
    if(argc == 5 && argv[1][0] != 'p') {
        char command = argv[1][0];
        char mode = argv[1][1];
        NSString *path = [NSString stringWithUTF8String:argv[2]];
        NSUInteger width = atoi(argv[3]);
        NSUInteger height = atoi(argv[4]);
        
        NSString *image = @"";
        BOOL icon = (mode == 'i') ? YES : NO;
        if (command == 't') {
            image = [ImagePreviewDumper terminalPreviewFor:path ofSize:NSMakeSize(width, height) asIcon:icon];
        } else if(command == 'd') {
            image = [ImagePreviewDumper dataPreviewFor:path ofSize:NSMakeSize(width, height) asIcon:icon];
        }
        printf("%s", [image UTF8String]);
        fflush(stdout);
        return 0;
    }
    
    return NSApplicationMain(argc, argv);
}
