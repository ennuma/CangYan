//
//  GuanYuan.m
//  Ennuma
//
//  Created by Zhaoyang on 14-7-28.
//  Copyright (c) 2014年 Zhaoyang. All rights reserved.
//

#import "GuanYuan.h"

@implementation GuanYuan
@synthesize guanyuanname = _guanyuanname;
@synthesize qinglian = _qinglian;
@synthesize zhihui = _zhihui;
@synthesize zhongcheng = _zhongcheng;
@synthesize age = _age;
@synthesize juewei = _juewei;
@synthesize guanzhi = _guanzhi;
@synthesize fenglu = _fenglu;

-(id)init
{
    self = [super init];
    if (!self) {
        return nil;
    }
    self.guanyuanname = @"无";
    self.qinglian = 0;
    self.zhihui = 0;
    self.wuli = 0;
    self.zhongcheng=0;
    self.age = 0;
    self.juewei = @"无";
    self.guanzhi = @"无";
    return self;
}

@end
