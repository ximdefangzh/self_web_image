//
//  WebImageOperation.h
//  self_web_image
//
//  Created by ximdefangzh on 16/8/22.
//  Copyright © 2016年 ximdefangzh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSString+cachePath.h"

@interface WebImageOperation : NSOperation
-(void)downloadImageWithUrlStr:(NSString *)urlStr finishedBlock:(void(^)(UIImage *image))finishedBlock;
@end
