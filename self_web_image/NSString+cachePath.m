//
//  NSString+cachePath.m
//  self_web_image
//
//  Created by ximdefangzh on 16/8/22.
//  Copyright © 2016年 ximdefangzh. All rights reserved.
//

#import "NSString+cachePath.h"

@implementation NSString (cachePath)
-(NSString *)getCachePath{
    NSString *cachePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
    return [cachePath stringByAppendingPathComponent:[self lastPathComponent]];
}
@end
