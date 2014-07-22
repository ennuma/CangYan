//
//  Wugong_YiJingShenGong.m
//  Ennuma
//
//  Created by ennuma on 14-7-22.
//  Copyright 2014年 ennuma. All rights reserved.
//
/**
 【易筋神功】能力解说：
 加力威力：1400--1600
 护体威力：1400--1600
 一般特效：
 完全抗毒
 封穴恢复速度每时序增加1
 行动后恢复内伤15点
 主功体特效：
 完全抗毒
 封穴恢复速度每时序增加2
 行动后恢复内伤30点
 攻击时应耗体力减5
 主功体加成武功：
 『降龙十八掌』人物行动后集气恢复250点
 『六脉神剑』功体加力时降低对手怒气值20点

 **/
#import "Wugong_YiJingShenGong.h"


@implementation Wugong_YiJingShenGong
-(void)initWugongDamageForEachLevelAndQigongValue
{
    _neigongHuTi = 1500;
    _neigongJiaLi = 1500;
}

-(void)initWugongNameAndLevelAndAcumeCost
{
    _wugongName = @"易经神功";
    _level = 10;
}

-(bool)isNeiGong
{
    return true;
}
-(int)effectRestoreJiQi:(int)jiqi AfterAttackWithInvader:(NSObject *)invader WithWugong:(Wugong *)m_wugong
{
    NSAssert([invader isKindOfClass:[Invader class] ], @"nsobj is not invader");
    Invader* inv = (Invader*)invader;
    
    if ([inv.mainNeiGong isWugong:self.wugongName]) {
        if ([m_wugong isWugong:@"降龙十八掌"]) {
            jiqi+=250;
        }
    }
    return jiqi;
}
-(int)effectDefendPoision:(int)poision WithInvader:(NSObject *)invader WithWugong:(Wugong *)m_wugong
{
    return 0;
}
-(void)effectRestoreAfterActionWithInvader:(NSObject *)invader
{
    NSAssert([invader isKindOfClass:[Invader class] ], @"nsobj is not invader");
    Invader* inv = (Invader*)invader;
    
    if ([inv.mainNeiGong isWugong:self.wugongName]) {
        int neishang = MAX(0, inv.bleed-30);
        inv.bleed = neishang;
    }else{
        int neishang = MAX(0, inv.bleed-15);
        inv.bleed = neishang;
    }
}
-(float)effectStamina:(float)stamina WithInvader:(NSObject *)invader WithWugong:(Wugong *)m_wugong
{
    NSAssert([invader isKindOfClass:[Invader class] ], @"nsobj is not invader");
    Invader* inv = (Invader*)invader;
    
    if ([inv.mainNeiGong isWugong:self.wugongName]) {
        stamina = MAX(1, stamina-5);
    }
    
    return stamina;
}
-(void)effectInUpdateJiQi:(NSObject *)invader
{
    NSAssert([invader isKindOfClass:[Invader class] ], @"nsobj is not invader");
    Invader* inv = (Invader*)invader;
    
    if ([inv.mainNeiGong isWugong:self.wugongName]) {
        inv.fengXue -= 2;
        if (inv.fengXue<0) {
            inv.fengXue=0;
        }
    }else{
        inv.fengXue -= 1;
        if (inv.fengXue<0) {
            inv.fengXue=0;
        }
    }
}
-(int)effectNeiGongJiaLiAngryHurt:(int)angry WithInvader:(NSObject *)invader WithWugong:(Wugong *)m_wugong
{
    NSAssert([invader isKindOfClass:[Invader class] ], @"nsobj is not invader");
    Invader* inv = (Invader*)invader;
    
    if ([inv.mainNeiGong isWugong:self.wugongName]) {
        if ([m_wugong isWugong:@"六脉神剑"]) {
            angry+=20;
        }
    }
    return angry;
}
@end
