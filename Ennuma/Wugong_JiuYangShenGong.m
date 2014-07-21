//
//  Wugong_JiuYangShenGong.m
//  Ennuma
//
//  Created by ennuma on 14-7-20.
//  Copyright 2014年 ennuma. All rights reserved.
//
/**
 【九阳神功】能力解说：
 加力威力：1300--1500
 护体威力：1500--1800
 一般特效：
 每一时序恢复5点内力
 被攻击所受伤害减少10%
 主功体特效：
 ※将九阳神功设为主功体需要阳性内力
 被攻击所受伤害减少30%
 每1时序恢复15点内力和2点内伤
 以调和内力同时练成九阴九阳学会特技{森罗万象}//TODO
 [森罗万象]免疫暴击的伤害加成
 主功体加成武功：
 『苗家剑法』人物行动后集气恢复150点
 『倚天屠龙功』加力成功时追加伤害80点
 『燃木刀法』加力成功时追加杀集气150点
 **/
#import "Wugong_JiuYangShenGong.h"


@implementation Wugong_JiuYangShenGong
-(void)initWugongDamageForEachLevelAndQigongValue
{
    _neigongHuTi = 1400;
    _neigongJiaLi = 1650;
}

-(void)initWugongNameAndLevelAndAcumeCost
{
    _wugongName = @"九阳神功";
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
        if ([m_wugong isWugong:@"苗家剑法"]) {
            jiqi += 150;
        }
    }
    
    return jiqi;
}
-(int)effectNeiGongJiaLiSpdHurt:(int)spdhurt WithInvader:(NSObject *)invader WithWugong:(Wugong *)m_wugong
{
    NSAssert([invader isKindOfClass:[Invader class] ], @"nsobj is not invader");
    Invader* inv = (Invader*)invader;
    
    if ([inv.mainNeiGong isWugong:self.wugongName]) {
        if ([m_wugong isWugong:@"燃木刀法"]) {
            spdhurt += 150;
            //CCLOG(@"here");
        }
        
    }
    
    return spdhurt;
}
-(int)effectNeiGongJiaLiHurt:(int)attackNg WithInvader:(NSObject *)invader WithWugong:(Wugong *)m_wugong
{
    NSAssert([invader isKindOfClass:[Invader class] ], @"nsobj is not invader");
    Invader* inv = (Invader*)invader;
    
    if ([inv.mainNeiGong isWugong:self.wugongName]) {
        if ([m_wugong isWugong:@"倚天屠龙功"]) {
            attackNg += 80;
        }
    }
    
    return attackNg;
}
-(int)effectLifeHurtAfterCalculate:(int)hurt WithDef:(NSObject *)def WithWugong:(Wugong *)m_wugong
{
    NSAssert([def isKindOfClass:[Invader class] ], @"nsobj is not invader");
    Invader* inv = (Invader*)def;
    
    if ([inv.mainNeiGong isWugong:self.wugongName]) {
        hurt = hurt*0.7;
    }else{
        hurt = hurt*0.9;
    }
    return hurt;
}
-(void)effectInUpdateJiQi:(NSObject *)invader
{
    NSAssert([invader isKindOfClass:[Invader class] ], @"nsobj is not invader");
    Invader* inv = (Invader*)invader;
    
    if ([inv.mainNeiGong isWugong:self.wugongName]) {
        //15 内力
        inv.acume+=15;
        if (inv.acume>inv.maxacume) {
            inv.acume = inv.maxacume;
        }
        //3 内伤
        inv.bleed-=2;
        if (inv.bleed<0) {
            inv.bleed = 0;
        }
    }else{
        inv.acume+=5;
        if (inv.acume>inv.maxacume) {
            inv.acume = inv.maxacume;
        }
    }
    
}

@end
