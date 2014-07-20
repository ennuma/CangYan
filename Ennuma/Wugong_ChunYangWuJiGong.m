//
//  Wugong_ChunYangWuJiGong.m
//  Ennuma
//
//  Created by ennuma on 14-7-19.
//  Copyright 2014年 ennuma. All rights reserved.
//
/**
 【纯阳无极功】能力解说：
 加力威力：1000--1100
 护体威力：1000--1100
 一般特效：
 攻击时内力消耗值减少25%
 每3时序恢复1点中毒
 主功体特效：
 攻击时内力消耗值减少50%
 每1时序恢复1点中毒
 人物行动后恢复内伤15点
 主功体加成武功：
 『太极拳』功体加力时伤害提升25%
 『太极剑法』人物行动后集气恢复150点

 **/

#import "Wugong_ChunYangWuJiGong.h"


@implementation Wugong_ChunYangWuJiGong

-(void)initWugongDamageForEachLevelAndQigongValue
{
    _neigongHuTi = 1050;
    _neigongJiaLi = 1050;
}

-(void)initWugongNameAndLevelAndAcumeCost
{
    _wugongName = @"纯阳无极功";
    _level = 10;
}

-(bool)isNeiGong
{
    return true;
}


-(int)effectNeiGongJiaLiHurt:(int)hurt WithInvader:(NSObject*)invader WithWugong:(Wugong *)m_wugong
{
    NSAssert([invader isKindOfClass:[Invader class] ], @"nsobj is not invader");
    Invader* inv = (Invader*)invader;
    if ([inv.mainNeiGong isWugong:self.wugongName]) {
        if ([m_wugong isWugong:@"太极拳"]) {
            hurt *= 1.25;
            //CCLOG(@"here");
        }
        
    }
    return hurt;
}

-(void)effectAfterAction:(NSObject *)invader
{
    NSAssert([invader isKindOfClass:[Invader class] ], @"nsobj is not invader");
    Invader* inv = (Invader*)invader;
    if ([inv.mainNeiGong isWugong:self.wugongName]) {
        inv.bleed -= 15;
        if (inv.bleed<0) {
            inv.bleed = 0;
        }
    }else{
        
    }
}

-(void)effectInUpdateJiQi:(NSObject *)invader
{
    NSAssert([invader isKindOfClass:[Invader class] ], @"nsobj is not invader");
    Invader* inv = (Invader*)invader;

    timer+=1;
    int bound = 0;
    if ([inv.mainNeiGong isWugong:self.wugongName]) {
        bound = 1;
    }else{
        bound = 3;
    }

    if (timer>=bound) {
        inv.poision -=1;
        if (inv.poision<0) {
            inv.poision = 0;
        }
        timer = 0;
    }
}
-(int)effectReduceAcumeCost:(int)acumecost WithInvader:(NSObject *)invader WithWugong:(Wugong *)m_wugong
{
    NSAssert([invader isKindOfClass:[Invader class] ], @"nsobj is not invader");
    Invader* inv = (Invader*)invader;
    
    int retcost = 0;
    
    if ([inv.mainNeiGong isWugong:self.wugongName]) {
        retcost = acumecost*0.5;
    }else{
        retcost = acumecost*0.75;
    }
    
    return retcost;
}
-(int)effectRestoreJiQi:(int)jiqi AfterAttackWithInvader:(NSObject *)invader WithWugong:(Wugong *)m_wugong
{
    NSAssert([invader isKindOfClass:[Invader class] ], @"nsobj is not invader");
    Invader* inv = (Invader*)invader;
    
    if ([inv.mainNeiGong isWugong:self.wugongName]) {
        if ([m_wugong isWugong:@"太极剑法"]) {
            jiqi += 150;
            //CCLOG(@"here");
        }
        
    }
    return jiqi;
}
@end
