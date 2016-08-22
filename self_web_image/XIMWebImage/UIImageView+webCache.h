//
//  UIImageView+webCache.h
//  self_web_image
//
//  Created by ximdefangzh on 16/8/22.
//  Copyright © 2016年 ximdefangzh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (webCache)
-(void)XIM_SetImageWithUrlStr:(NSString *)urlStr;
@property (nonatomic,copy)NSString *lastUrl;
@end
