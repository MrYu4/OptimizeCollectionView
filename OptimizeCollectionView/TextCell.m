//
// Created by gehot mail on 2019-02-21.
// Copyright (c) 2019 YaHaHa_. All rights reserved.
//

#import "TextCell.h"

@interface TextCell()

@property (nonatomic, strong) UILabel *titleLb;/**<标题 label*/
@property (nonatomic, strong) NSOperationQueue *queue;/**<队列*/
@property (nonatomic, strong) NSString *dataStr;/**<储存数据*/
@end

@implementation TextCell
- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        [self setViews];
    }
    return self;
}

- (void)setViews {

    [self addSubview:self.titleLb];
    self.titleLb.frame = self.bounds;
}

- (UILabel *)titleLb {

    if (!_titleLb) {
        _titleLb = ({
            UILabel *lb = [UILabel new];
            lb.font = [UIFont italicSystemFontOfSize:20];
            lb.textColor = [UIColor blackColor];
            lb.text = @"No Data";
            lb;
        });
    }
    return _titleLb;
}

- (NSOperationQueue *)queue {

    if (!_queue) {
        _queue = ({
            NSOperationQueue *q = [[NSOperationQueue alloc]init];
            //设置最大并行操作数为1相当于将queue设置为串行线程
            q.maxConcurrentOperationCount = 1;
            q;
        });
    }
    return _queue;
}

- (void)loadNewData:(NSString *)titleStr {

    self.dataStr = titleStr;
    self.titleLb.text = nil;
    //    //模拟十分耗时间的操作
    //    [NSThread sleepForTimeInterval:0.05];
    //    self.titleLb.text = titleStr;
    if (self.queue.operationCount >= 2) {
        //如果self.queue.operations[0]正在执行的话，不会被强行中止
        [self.queue cancelAllOperations];
    }
    NSInvocationOperation *operation = [[NSInvocationOperation alloc]
            initWithTarget:self
                  selector:@selector(optimizeOperation:)
                    object:titleStr];
    [self.queue addOperation:operation];
}

- (void)optimizeOperation:(NSString *)dataStr {

    //模拟十分耗时间的操作
    [NSThread sleepForTimeInterval:0.05];
    if ([dataStr isEqualToString:self.dataStr]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.titleLb.text = dataStr;
        });
    }

}
@end