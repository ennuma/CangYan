//
//  XianTianGong.m
//  Ennuma
//
//  Created by ennuma on 14-7-22.
//  Copyright 2014年 ennuma. All rights reserved.
//
/**
 【先天功】能力解说：
 加力威力：1100--1250
 护体威力：1150--1300
 一般特效：
 每2时序恢复1点内伤
 每2时序恢复1点中毒
 主功体特效：
 每1时序恢复2点内伤
 每1时序恢复2点中毒
 封穴恢复速度每时序增加1
 免疫集气值在负500再受到杀气伤害时追加的内伤及生命伤害//TODO
 主功体加成武功：
 『空明拳』功体加力时降低对手怒气值10点
 『一阳指』功体加力时封穴10点//成功率提升50% 
 『七星剑法』功体加力时追加伤害70点
 **/
#import "Wugong_XianTianGong.h"


@implementation XianTianGong

-(void)initWugongDamageForEachLevelAndQigongValue
{
    _neigongHuTi = 1175;
    _neigongJiaLi = 1225;
    time = 0;
}

-(void)initWugongNameAndLevelAndAcumeCost
{
    _wugongName = @"先天功";
    _level = 10;
}

-(bool)isNeiGong
{
    return true;
}
-(void)effectInUpdateJiQi:(NSObject *)invader
{
    NSAssert([invader isKindOfClass:[Invader class] ], @"nsobj is not invader");
    Invader* inv = (Invader*)invader;
    
    time+=1;
    int bound = 0;
    if ([inv.mainNeiGong isWugong:self.wugongName]) {
        bound = 1;
        if (time>=bound) {
            inv.poision -=2;
            if (inv.poision<0) {
                inv.poision = 0;
            }
            inv.bleed -=2;
            if (inv.bleed<0) {
                inv.bleed = 0;
            }
            inv.fengXue -=1;
            if (inv.fengXue<0) {
                inv.fengXue = 0;
            }

            time = 0;
        }

    }else{
        bound = 2;
        if (time>=bound) {
            inv.poision -=1;
            if (inv.poision<0) {
                inv.poision = 0;
            }
            inv.bleed -=1;
            if (inv.bleed<0) {
                inv.bleed = 0;
            }
            time = 0;
        }

    }
}
-(int)effectNeiGongJiaLiHurt:(int)hurt WithInvader:(NSObject *)invader WithWugong:(Wugong *)m_wugong
{
    NSAssert([invader isKindOfClass:[Invader class] ], @"nsobj is not invader");
    Invader* inv = (Invader*)invader;
    
    if ([inv.mainNeiGong isWugong:self.wugongName]) {
        if ([m_wugong isWugong:@"七星剑法"]) {
            hurt += 70;
        }
    }
    
    return hurt;
}
-(int)effectNeiGongJiaLiAngryHurt:(int)angry WithInvader:(NSObject *)invader WithWugong:(Wugong *)m_wugong
{
    NSAssert([invader isKindOfClass:[Invader class] ], @"nsobj is not invader");
    Invader* inv = (Invader*)invader;
    
    if ([inv.mainNeiGong isWugong:self.wugongName]) {
        if ([m_wugong isWugong:@"空明拳"]) {
            angry += 10;
        }
    }
    
    return angry;
}
-(int)effectNeiGongJiaLiFengXueHurt:(int)fengxue WithInvader:(NSObject *)invader WithWugong:(Wugong *)m_wugong
{
    NSAssert([invader isKindOfClass:[Invader class] ], @"nsobj is not invader");
    Invader* inv = (Invader*)invader;
    
    if ([inv.mainNeiGong isWugong:self.wugongName]) {
        if ([m_wugong isWugong:@"一阳指"]) {
            fengxue += 10;
        }
    }
    return fengxue;
}
@end
