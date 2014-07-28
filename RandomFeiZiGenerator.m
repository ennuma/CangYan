//
//  RandomFeiZiGenerator.m
//  Ennuma
//
//  Created by Zhaoyang on 14-7-27.
//  Copyright (c) 2014年 Zhaoyang. All rights reserved.
//

#import "RandomFeiZiGenerator.h"

@implementation RandomFeiZiGenerator
static RandomFeiZiGenerator* sharedGenerator;
+(RandomFeiZiGenerator*)sharedRandomFeiZiGenerator
{
    if (sharedGenerator) {
        return sharedGenerator;
    }
    
    return [[self alloc] init];
}
-(FeiZi*)generateFeiZi
{
    FeiZi* ret = [FeiZi node];
    ret.feiziname = @"随机生成";
    ret.jieshao = @"无";
    ret.beijing = @"无";
    ret.meili = 30+CCRANDOM_0_1()*70-20;
    return ret;
}
@end
