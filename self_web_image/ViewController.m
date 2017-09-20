//
//  ViewController.m
//  self_web_image
//
//  Created by ximdefangzh on 16/8/22.
//  Copyright © 2016年 ximdefangzh. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"
#import "UIImageView+webCache.h"

#define URLStr @"https://raw.githubusercontent.com/ximdefangzh/XIMSelfImage/master/apps.json"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@end

@implementation ViewController{
    NSArray<NSString *> *_urlList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //
    [self loadData];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self setImage];
}
-(void)setImage{
    uint32_t ramdom = arc4random_uniform((uint32_t)_urlList.count);
    [self.imgView XIM_SetImageWithUrlStr:_urlList[ramdom]];
}
-(void)loadData{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableArray<NSString *> *arrM = [NSMutableArray array];
    [manager GET:URLStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSArray<NSDictionary *> *responseObject) {
        [responseObject enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [arrM addObject:[obj valueForKey:@"icon"]];
        }];
        _urlList = [arrM copy];
    } failure:nil];
    NSLog(@"loadData done");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
