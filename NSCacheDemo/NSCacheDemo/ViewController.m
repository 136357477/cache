//
//  ViewController.m
//  NSCacheDemo
//
//  Created by guohui on 16/7/7.
//  Copyright © 2016年 guohui. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<NSCacheDelegate>
//声明NSCache变量:
@property (nonatomic, strong) NSCache *cache;

@end

@implementation ViewController
//懒加载：
- (NSCache *)cache {
    if (_cache == nil) {
        _cache = [[NSCache alloc] init];
        // 设置数量限制,最大限制为10
        _cache.countLimit = 10;
        _cache.delegate = self;
    }
    return _cache;
}

//测试Demo:
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    for (int i = 0; i < 20; ++i) {
        NSString *str = [NSString stringWithFormat:@"hello - %04d", i];
        
        NSLog(@"设置 %@", str);
        // 添加到缓存
//        [self.cache setObject:str forKey:@(i)];
        UIImage *image = [UIImage imageNamed:@"1.png"];
        [self.cache setObject:image forKey:@(i) cost:10];
    }
    // - 查看缓存内容，NSCache 没有提供遍历的方法，只支持用 key 来取值
    for (int i = 0; i < 20; ++i) {
        NSLog(@"缓存中----->%@", [self.cache objectForKey:@(i)]);
    }
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//实现代理方法：
// MARK: NSCache Delegate
// 当缓存中的对象被清除的时候，会自动调用
// obj 就是要被清理的对象
// 提示：不建议平时开发时重写！仅供调试使用
- (void)cache:(NSCache *)cache willEvictObject:(id)obj {
    [NSThread sleepForTimeInterval:0.5];
    NSLog(@"清除了-------> %@", obj);
}

@end
