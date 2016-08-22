//
//  UIImageView+webCache.m
//  self_web_image
//
//  Created by ximdefangzh on 16/8/22.
//  Copyright © 2016年 ximdefangzh. All rights reserved.
//

#import "UIImageView+webCache.h"
#import "WebImageManager.h"
#import "objc/runtime.h"

@implementation UIImageView (webCache)
-(void)setLastUrl:(NSString *)lastUrl{
    objc_setAssociatedObject(self, @"key", lastUrl, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
-(NSString *)lastUrl{
    return objc_getAssociatedObject(self, @"key");
}
-(void)XIM_SetImageWithUrlStr:(NSString *)urlStr{
    if(urlStr){
        if(self.lastUrl){
            if(![self.lastUrl isEqualToString:urlStr]){
                [[WebImageManager sharedManager] cancelOperationWithUrl:self.lastUrl];
            }
        }

        [[WebImageManager sharedManager] downloadImageWithUrl:urlStr finishedBlock:^(UIImage *image) {
            self.image = image;
//            NSLog(@"%@",[NSThread currentThread]);
        }];
        self.lastUrl = urlStr;
    }
}
@end
