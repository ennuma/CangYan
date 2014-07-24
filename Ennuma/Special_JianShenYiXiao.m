//
//  Special_JianShenYiXiao.m
//  Ennuma
//
//  Created by ennuma on 14-7-24.
//  Copyright 2014年 ennuma. All rights reserved.
//
/**
每练习一种剑法到自身集气速度提升5%
每修习一种剑法到剑法类攻击追加5点伤害
 **/
#import "Special_JianShenYiXiao.h"


@implementation Special_JianShenYiXiao
-(void)effectInUpdateJiQi:(NSObject *)invader
{
    NSAssert([invader isKindOfClass:[Invader class] ], @"nsobj is not invader");
    Invader* inv = (Invader*)invader;

    float jiqispeed = inv.jiqispeed;
    int count = 0;
    for (Wugong* wg in inv.wugongArr) {
        if ([wg isJianFa]) {
            count++;
        }
    }
    float incjiqi = jiqispeed*count*5/100;
    inv.amountofjiqi+=incjiqi;
}
-(int)effectLifeHurtAfterCalculate:(int)hurt WithAtk:(NSObject *)atk WithWugong:(Wugong *)m_wugong
{
    NSAssert([atk isKindOfClass:[Invader class] ], @"nsobj is not invader");
    Invader* inv = (Invader*)atk;

    int count = 0;
    for (Wugong* wg in inv.wugongArr) {
        if ([wg isJianFa]) {
            count++;
        }
    }
    hurt += count*5;
    return hurt;
}
@end
