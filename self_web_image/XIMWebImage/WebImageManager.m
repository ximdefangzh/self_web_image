//
//  WebImageManager.m
//  self_web_image
//
//  Created by ximdefangzh on 16/8/22.
//  Copyright © 2016年 ximdefangzh. All rights reserved.
//

#import "WebImageManager.h"
#import "WebImageOperation.h"


@implementation WebImageManager{
    NSOperationQueue *_queue;
    NSMutableDictionary *_opList;
//    NSString *_lastUrl;
    NSCache *_imgCache;
}
-(instancetype)init{
    if(self = [super init]){
        _queue = [[NSOperationQueue alloc] init];
        _opList = [NSMutableDictionary dictionary];
        _imgCache = [[NSCache alloc] init];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clearCache) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
    }
    return self;
}
-(void)clearCache{
    [_imgCache removeAllObjects];
    [_queue cancelAllOperations];
    [_opList removeAllObjects];
}
+(instancetype)sharedManager{
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [self new];
    });
    return instance;
}
-(void)downloadImageWithUrl:(NSString *)url finishedBlock:(void (^)(UIImage *))finishBlock{
    if([_opList objectForKey:url]){
        return;
    }
    
    if([self haveCache:url]){
        if(finishBlock){
            finishBlock([_imgCache objectForKey:url]);
        }
        return;
    }
    
//    if(_lastUrl){
//        if(![_lastUrl isEqualToString:url]){
//            WebImageOperation *op = [_opList objectForKey:_lastUrl];
//            [op cancel];
//            [_opList removeObjectForKey:_lastUrl];
//        }
//    }
    WebImageOperation *op = [[WebImageOperation alloc] init];
    [NSThread sleepForTimeInterval:1.0];
    [op downloadImageWithUrlStr:url finishedBlock:^(UIImage *image) {
        if(finishBlock){
            finishBlock(image);
            [_imgCache setObject:image forKey:url];
        }
        [_opList removeObjectForKey:url];
    }];
//    _lastUrl = url;
    [_opList setObject:op forKey:url];
    [_queue addOperation:op];
}
-(BOOL)haveCache:(NSString *)urlStr{
    UIImage *img = [_imgCache objectForKey:urlStr];
    if(img){
        NSLog(@"memonry....%@",urlStr);
        return YES;
    }
    NSString *path = [urlStr getCachePath];
    img = [UIImage imageWithData:[NSData dataWithContentsOfFile:path]];
    if(img){
        NSLog(@"sanda....%@",urlStr);
        [_imgCache setObject:img forKey:urlStr];
        return YES;
    }
    return NO;
}
-(void)cancelOperationWithUrl:(NSString *)urlStr{
    if(urlStr){
        WebImageOperation *op = [_opList objectForKey:urlStr];
        if(op){
            [op cancel];
            [_opList removeObjectForKey:urlStr];
        }
    }
}
@end
