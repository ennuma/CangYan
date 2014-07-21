//
//  Wugong_JiuYinShenGong.m
//  Ennuma
//
//  Created by ennuma on 14-7-21.
//  Copyright 2014年 ennuma. All rights reserved.
//
/**
 【九阴神功】能力解说：
 加力威力：1600--1900
 护体威力：1200--1400
 一般特效：
 每时序恢复1点或2点生命，
 攻击时伤害增加10%
 主功体特效：
 ※将九阴神功设为主功体需要阴性内力
 攻击时伤害增加30%
 每1时序恢复3点生命和2点流血状态
 以调和内力同时练成九阴九阳学会特技{森罗万象}//TODO
 [森罗万象]免疫暴击的伤害加成
 主功体加成武功：
 『九阴白骨爪』必定连击 35%概率三连击//TODO
 『弹指神通』武功威力提升500
 『降龙十八掌』消耗内力降低70%

 **/
#import "Wugong_JiuYinShenGong.h"


@implementation Wugong_JiuYinShenGong

-(void)initWugongDamageForEachLevelAndQigongValue
{
    _neigongHuTi = 1750;
    _neigongJiaLi = 1300;
}

-(void)initWugongNameAndLevelAndAcumeCost
{
    _wugongName = @"九阴神功";
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
    
    if ([inv.mainNeiGong isWugong:self.wugongName]) {
        //3 health
        int restorelife = 3;
        inv.health+=restorelife;
        if (inv.health>inv.maxhealth) {
            inv.health = inv.maxhealth;
        }
        //3 内伤
        inv.liuXue-=2;
        if (inv.liuXue<0) {
            inv.liuXue = 0;
        }
    }else{
        int restorelife = 1 + CCRANDOM_0_1()*2;
        inv.health+=restorelife;
        if (inv.health>inv.maxhealth) {
            inv.health = inv.maxhealth;
        }
    }
    

}

-(int)effectLifeHurtAfterCalculate:(int)hurt WithAtk:(NSObject *)atk WithWugong:(Wugong *)m_wugong
{
    NSAssert([atk isKindOfClass:[Invader class] ], @"nsobj is not invader");
    Invader* inv = (Invader*)atk;
    
    if ([inv.mainNeiGong isWugong:self.wugongName]) {
        hurt = hurt*1.3;
        if ([m_wugong isWugong:@"九阴白骨爪"]) {
            hurt *= 1.7; //fake effect here
        }
    }else{
        hurt = hurt*1.1;
    }
    
    return hurt;
}

-(int)effectWugongDamage:(int)wugongDamage WithInvader:(NSObject *)invader WithWugong:(Wugong *)m_wugong
{
    NSAssert([invader isKindOfClass:[Invader class] ], @"nsobj is not invader");
    Invader* inv = (Invader*)invader;
    
    if ([inv.mainNeiGong isWugong:self.wugongName]) {
        if ([m_wugong isWugong:@"弹指神通"]) {
            wugongDamage += 500;
            //CCLOG(@"here");
        }
        
    }
    return wugongDamage;
}

-(int)effectReduceAcumeCost:(int)acumecost WithInvader:(NSObject *)invader WithWugong:(Wugong *)m_wugong
{
    NSAssert([invader isKindOfClass:[Invader class] ], @"nsobj is not invader");
    Invader* inv = (Invader*)invader;

    if ([inv.mainNeiGong isWugong:self.wugongName]) {
        if ([m_wugong isWugong:@"降龙十八掌"]) {
            acumecost *= 0.3;
            //CCLOG(@"here");
        }
    }
    
    return acumecost;
}

@end
