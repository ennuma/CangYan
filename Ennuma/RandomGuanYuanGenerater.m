//
//  RandomGuanYuanGenerater.m
//  Ennuma
//
//  Created by Zhaoyang on 14-7-28.
//  Copyright (c) 2014年 Zhaoyang. All rights reserved.
//

#import "RandomGuanYuanGenerater.h"
#import "RandomNameGenerater.h"
@implementation RandomGuanYuanGenerater
static RandomGuanYuanGenerater* sharedGenerator;
+(RandomGuanYuanGenerater*)sharedRandomGuanYuanGenerator
{
    if (sharedGenerator) {
        return sharedGenerator;
    }
    sharedGenerator = [[self alloc] init];
    return sharedGenerator;
}
-(GuanYuan*)generateGuanyuan
{
    GuanYuan* ret = [GuanYuan node];
    ret.guanyuanname = [[RandomNameGenerater sharedRandomNameGenerator]generateName:@"男"];
    ret.juewei = @"无";
    ret.guanzhi = @"无";
    ret.wuli = 30+CCRANDOM_0_1()*70-20;
    ret.zhihui = 30+CCRANDOM_0_1()*70-20;
    ret.zhongcheng = 30+CCRANDOM_0_1()*70-20;
    ret.age = 30+CCRANDOM_0_1()*70-20;
    ret.fenglu = 1000;
    return ret;
}

@end
