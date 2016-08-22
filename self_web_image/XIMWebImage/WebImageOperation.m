//
//  WebImageOperation.m
//  self_web_image
//
//  Created by ximdefangzh on 16/8/22.
//  Copyright © 2016年 ximdefangzh. All rights reserved.
//

#import "WebImageOperation.h"
@interface WebImageOperation()
@property (copy, nonatomic) NSString *urlStr;
@property (copy, nonatomic) void(^finishedBlock)();
@end
@implementation WebImageOperation
-(void)main{
    if(self.urlStr){
        NSURL *url = [NSURL URLWithString:self.urlStr];
        NSData *data = [NSData dataWithContentsOfURL:url];
        [data writeToFile:[self.urlStr getCachePath] atomically:YES];
        
        UIImage *img = [UIImage imageWithData:data];
        if(self.isCancelled){
            NSLog(@"cancel....");
            return;
        }
        NSLog(@"download.....%@",self.urlStr);
        if(self.finishedBlock){
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
               self.finishedBlock(img); 
            }];
        }
    }
}
-(void)downloadImageWithUrlStr:(NSString *)urlStr finishedBlock:(void (^)(UIImage *))finishedBlock{
    self.urlStr = urlStr;
    self.finishedBlock = finishedBlock;
}
@end
