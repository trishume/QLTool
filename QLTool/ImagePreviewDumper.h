//
//  ImagePreviewDumper.h
//  QLTool
//
//  Created by Tristan Hume on 2014-05-25.
//  Copyright (c) 2014 Tristan Hume. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImagePreviewDumper : NSObject

+ (NSString*)dataPreviewFor:(NSString*)path ofSize:(NSSize)size asIcon:(BOOL)icon;
+ (NSString*)terminalPreviewFor:(NSString*)path ofSize:(NSSize)size asIcon:(BOOL)icon;
+ (NSString *)resolvePath:(NSString *)path;

@end
