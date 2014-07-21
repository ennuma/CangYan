//
//  Wugong_LongXiangBoRuoGong.m
//  Ennuma
//
//  Created by ennuma on 14-7-21.
//  Copyright 2014年 ennuma. All rights reserved.
//
/**
 【龙象般若功】能力解说：
 加力威力：1300-1600
 护体威力：1100-1400
 一般特效：
 加力后杀集气增加20%//破防后可追加伤害值的30%杀集气
 每3时序恢复内伤1点
 主功体特效：
 加力后杀集气增加40%//破防后可追加伤害值的60%杀集气
 每1时序恢复内伤1点
 人物战意提升速度增加35%
 主功体加成武功：
 『七伤拳』功体加力时伤害提升40%
 『玄铁剑法』功体加力时追加伤害80点
 『无上大力杵』人物行动后恢复集气值300点
 **/
#import "Wugong_LongXiangBoRuoGong.h"


@implementation Wugong_LongXiangBoRuoGong
-(void)initWugongDamageForEachLevelAndQigongValue
{
    _neigongHuTi = 1450;
    _neigongJiaLi = 1250;
}

-(void)initWugongNameAndLevelAndAcumeCost
{
    _wugongName = @"龙象般若功";
    _level = 10;
    time = 0;
}

-(bool)isNeiGong
{
    return true;
}
-(int)effectNeiGongJiaLiHurt:(int)hurt WithInvader:(NSObject *)invader WithWugong:(Wugong *)m_wugong
{
    NSAssert([invader isKindOfClass:[Invader class] ], @"nsobj is not invader");
    Invader* inv = (Invader*)invader;
    
    if ([inv.mainNeiGong isWugong:self.wugongName]) {
        if ([m_wugong isWugong:@"七伤拳"]) {
            hurt *= 1.4;
        }
        if ([m_wugong isWugong:@"玄铁剑法"]) {
            hurt += 80;
        }
    }
    
    return hurt;
}
-(int)effectRestoreJiQi:(int)jiqi AfterAttackWithInvader:(NSObject *)invader WithWugong:(Wugong *)m_wugong
{
    NSAssert([invader isKindOfClass:[Invader class] ], @"nsobj is not invader");
    Invader* inv = (Invader*)invader;
    
    if ([inv.mainNeiGong isWugong:self.wugongName]) {
        if ([m_wugong isWugong:@"无上大力杵"]) {
            jiqi+=300;
        }
    }
    return jiqi;
}
-(float)effectWillingToFight:(float)willingToFight WithInvader:(NSObject *)invader WithWugong:(Wugong *)m_wugong
{
    NSAssert([invader isKindOfClass:[Invader class] ], @"nsobj is not invader");
    Invader* inv = (Invader*)invader;
    
    if ([inv.mainNeiGong isWugong:self.wugongName]) {
        //8 jiqi
        willingToFight *= 1.35;
    }
    
    return willingToFight;
}
-(void)effectInUpdateJiQi:(NSObject *)invader
{
    NSAssert([invader isKindOfClass:[Invader class] ], @"nsobj is not invader");
    Invader* inv = (Invader*)invader;
    
    time+=1;
    int bound = 0;
    if ([inv.mainNeiGong isWugong:self.wugongName]) {
        bound = 1;
    }else{
        bound = 3;
    }
    
    if (time>=bound) {
        inv.bleed -=1;
        if (inv.bleed<0) {
            inv.bleed = 0;
        }
        time = 0;
    }

}
-(int)effectNeiGongJiaLiSpdHurt:(int)spdhurt WithInvader:(NSObject *)invader WithWugong:(Wugong *)m_wugong
{
    NSAssert([invader isKindOfClass:[Invader class] ], @"nsobj is not invader");
    Invader* inv = (Invader*)invader;
    
    if ([inv.mainNeiGong isWugong:self.wugongName]) {
        spdhurt *= 1.4;
    }else{
        spdhurt *= 1.2;
    }
    return spdhurt;
}

@end
