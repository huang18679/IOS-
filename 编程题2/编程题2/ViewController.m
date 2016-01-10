//
//  ViewController.m
//  编程题2
//
//  Created by LiYaogang on 15/8/25.
//  Copyright (c) 2015年 XiaoMaGe. All rights reserved.
//

#import "ViewController.h"

//刷新次数
static long steps;

@interface ViewController ()

@property (nonatomic, strong) CADisplayLink *timer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIImageView *bg = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    bg.image = [UIImage imageNamed:@"snowbg"];
    //设置图片显示的内容模式
    bg.contentMode = UIViewContentModeScaleAspectFill;
    
    [self.view addSubview:bg];
    
    self.timer = [CADisplayLink displayLinkWithTarget:self selector:@selector(update)];
    //加入运行循环
    [self.timer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
}

//点击的时候动画停止
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self stopTimer];
}

- (void)stopTimer
{
    [self.timer invalidate];
}

- (void)update
{
    steps++;
    //每秒钟执行一次
    if (steps % 5 == 0) {
        NSLog(@"come here %ld", steps);
        
        [self snow];
    }
    
}

//方法一 用transform属性设置

- (void)snow
{
    //1.实例化一个雪花的图像视图
    UIImage *image = [UIImage imageNamed:@"snow"];
    
    UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
    //0.3倍缩放
    CGFloat scale = 0.3;
    //设置雪花缩放
    imageView.transform = CGAffineTransformMakeScale(scale, scale);
    
    CGSize winSize = self.view.bounds.size;
    
    //2.添加到视图
    CGFloat x = arc4random_uniform(winSize.width);
    CGFloat y = -imageView.bounds.size.height * 0.5;
    
    imageView.center = CGPointMake(x, y);
    
    [self.view addSubview:imageView];
    
#define degree2angle(angle)  ((angle) * M_PI / 180)
    //3.动画下落
    [UIView animateWithDuration:10.0f animations:^{
        //移动到终点位置
        CGFloat toX = arc4random_uniform(winSize.width);
        CGFloat toY = winSize.height + imageView.bounds.size.height * 0.5;
        
        imageView.center = CGPointMake(toX, toY);
        //下过过程中,设置雪花360度随机旋转
        imageView.transform = CGAffineTransformRotate(imageView.transform, degree2angle(arc4random_uniform(360)));
        imageView.alpha = 0.3;
        
    } completion:^(BOOL finished) {
        [imageView removeFromSuperview];
    }];
    
}



//方法二 用kvc设置

/*
 - (void)snow
 {
 //1.实例化一个雪花的图像视图
 //整个视图的尺寸
 CGSize winSize = self.view.bounds.size;
 UIImage *image = [UIImage imageNamed:@"雪花"];
 
 UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
 //2.添加到视图
 CGFloat startX = arc4random_uniform(winSize.width);
 CGFloat startY = -imageView.bounds.size.height;
 imageView.center = CGPointMake(startX, startY);
 
 //0.3倍缩放缩放
 CGFloat scale = 0.3;
 [imageView.layer setValue:@(scale) forKeyPath:@"transform.scale"];
 
 [self.view addSubview:imageView];
 //3.动画下落
 [UIView animateWithDuration:10.0f animations:^{
 //移动到终点位置
 CGFloat endX = arc4random_uniform(winSize.width);
 CGFloat endY = winSize.height + imageView.bounds.size.height;
 imageView.center = CGPointMake(endX, endY);
 //下落的过程中旋转180度
 [imageView.layer setValue:@(M_PI) forKeyPath:@"transform.rotation"];
 //不透明度为0.3
 [imageView.layer setValue:@(0.3) forKeyPath:@"opacity"];
 
 } completion:^(BOOL finished) {
 //        结束动画移除imageView
 [imageView removeFromSuperview];
 NSLog(@"%d", self.view.subviews.count);
 
 }];
 
 }
 
 */

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
