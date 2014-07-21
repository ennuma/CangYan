//
//  Wugong_NiYunZhenJing.m
//  Ennuma
//
//  Created by ennuma on 14-7-21.
//  Copyright 2014年 ennuma. All rights reserved.
//
/**
 【逆运真经】能力解说：
 加力威力：1000-1800
 护体威力：1000-1600
 一般特效：
 集气速度大紊乱
 （练九阴神功后恢复
 免疫封穴
 主功体特效：
 集气速度小紊乱（练九阴神功后恢复)
 免疫封穴
 暴击伤害加成效果提升至75% 
 人物战意提升速度增加30%
 主功体加成武功：
 『黯然销魂掌』功体加力时降低对手怒气值30点
 『灭剑绝剑』功体加力时伤害提升40%
 **/
#import "Wugong_NiYunZhenJing.h"


@implementation Wugong_NiYunZhenJing

-(void)initWugongDamageForEachLevelAndQigongValue
{
    _neigongHuTi = 1400;
    _neigongJiaLi = 1300;
}

-(void)initWugongNameAndLevelAndAcumeCost
{
    _wugongName = @"逆运真经";
    _level = 10;
}

-(bool)isNeiGong
{
    return true;
}
-(int)effectBaojiEffect:(int)effect WithInvader:(NSObject *)invader WithWugong:(Wugong *)m_wugong
{
    effect = 1.75;
    return effect;
}
-(void)effectInUpdateJiQi:(NSObject *)invader
{
    NSAssert([invader isKindOfClass:[Invader class] ], @"nsobj is not invader");
    Invader* inv = (Invader*)invader;
    
    for (Wugong* wu in inv.wugongArr) {
        if ([wu isWugong:@"九阴神功"]) {
            return;
        }
    }
    
    if ([inv.mainNeiGong isWugong:self.wugongName]) {
        //集气大紊乱
        inv.amountofjiqi -= CCRANDOM_0_1()*inv.jiqispeed;
    }else{
        //集气小紊乱
        inv.amountofjiqi -= CCRANDOM_0_1()*inv.jiqispeed/2;
    }

}
-(float)effectWillingToFight:(float)willingToFight WithInvader:(NSObject *)invader WithWugong:(Wugong *)m_wugong
{
    NSAssert([invader isKindOfClass:[Invader class] ], @"nsobj is not invader");
    Invader* inv = (Invader*)invader;
    
    if ([inv.mainNeiGong isWugong:self.wugongName]) {
        //8 jiqi
        willingToFight *= 1.3;
    }
    
    return willingToFight;
}
-(int)effectNeiGongJiaLiHurt:(int)hurt WithInvader:(NSObject *)invader WithWugong:(Wugong *)m_wugong
{
    NSAssert([invader isKindOfClass:[Invader class] ], @"nsobj is not invader");
    Invader* inv = (Invader*)invader;
    
    if ([inv.mainNeiGong isWugong:self.wugongName]) {
        if ([m_wugong isWugong:@"灭剑绝剑"]) {
            hurt *= 1.4;
        }
    }
    
    return hurt;
}
-(int)effectNeiGongJiaLiAngryHurt:(int)angry WithInvader:(NSObject *)invader WithWugong:(Wugong *)m_wugong
{
    NSAssert([invader isKindOfClass:[Invader class] ], @"nsobj is not invader");
    Invader* inv = (Invader*)invader;
    
    if ([inv.mainNeiGong isWugong:self.wugongName]) {
        if ([m_wugong isWugong:@"黯然销魂掌"]) {
            angry += 30;
        }
    }
    
    return angry;
}
-(int)effectDefendFengXue:(int)fengxue WithInvader:(NSObject *)invader WithWugong:(Wugong *)m_wugong
{
    NSAssert([invader isKindOfClass:[Invader class] ], @"nsobj is not invader");
    Invader* inv = (Invader*)invader;
    //免疫封穴
    return 0;
}

@end
