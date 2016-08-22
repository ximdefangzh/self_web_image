//
//  WebImageManager.h
//  self_web_image
//
//  Created by ximdefangzh on 16/8/22.
//  Copyright © 2016年 ximdefangzh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebImageManager : NSObject
+(instancetype)sharedManager;
-(void)downloadImageWithUrl:(NSString *)url finishedBlock:(void(^)(UIImage *image))finishBlock;
-(void)cancelOperationWithUrl:(NSString *)urlStr;
@end
