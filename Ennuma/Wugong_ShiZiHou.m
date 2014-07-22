//
//  Wugong_ShiZiHou.m
//  Ennuma
//
//  Created by ennuma on 14-7-22.
//  Copyright 2014年 ennuma. All rights reserved.
//
/**
 【狮子吼】能力解说：
 加力威力：1000--1250
 护体威力：800--900
 一般特效：
 攻击时30%几率发动狮子战吼 对自身五格范围内敌人追加杀集气
 效果值为 （自身综合内力值-敌方当前内力值/2）/50+(自身战意-100)
 [综合内力]=（当前内力*2+最大内力）/3
 发动狮子吼后减当前内力值十分之一（上限为500点）
 主功体特效：
 攻击时75几率发动狮子战吼 对自身八格范围内敌人追加杀集气
 效果值为（自身综合内力值-敌方当前内力值/2）/50+(自身战意-100)2+30
 发动狮子吼后减当前内力值十分之一（上限为500点）
 注：狮子吼战吼在连击中不可发动 仅在第一击时才有效
 主功体加成武功：
 『大金刚掌』功体加力时伤害值提升30%
 『金刚伏魔圈』功体加力时追加伤害50点

 **/
#import "Wugong_ShiZiHou.h"


@implementation Wugong_ShiZiHou
-(void)initWugongDamageForEachLevelAndQigongValue
{
    _neigongHuTi = 1125;
    _neigongJiaLi = 850;
}

-(void)initWugongNameAndLevelAndAcumeCost
{
    _wugongName = @"狮子吼";
    _level = 10;
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
        if ([m_wugong isWugong:@"大金刚掌"]) {
            hurt *= 1.3;
        }
        if ([m_wugong isWugong:@"金刚伏魔圈"]) {
            hurt += 50;
        }
    }
    
    return hurt;
}
-(void)effectSpecialEffectScopeWithInvader:(NSObject *)invader WithWugong:(Wugong *)m_wugong
{
    NSAssert([invader isKindOfClass:[Invader class] ], @"nsobj is not invader");
    Invader* inv = (Invader*)invader;
    int scope = 0;
    int prob = 0;
    if ([inv.mainNeiGong isWugong:self.wugongName]) {
        scope = 5;
        prob = 30;
        if (CCRANDOM_0_1()*100<=prob) {
            for (Invader* en in inv.enemy) {
                if ((abs(en.position.x-inv.position.x)+abs(en.position.y-inv.position.y))<=scope) {
                    int spdhurt =  ((inv.acume*2+inv.maxacume)/3 - en.acume/2)/50 + inv.willingToFight-100;
                    en.amountofjiqi -= spdhurt;
                    int acumecost = MIN(500, inv.acume/10);
                    inv.acume-=acumecost;
                }
            }
        }
    }else{
        scope = 8;
        prob = 75;
        if (CCRANDOM_0_1()*100<=prob) {

        for (Invader* en in inv.enemy) {
            if ((abs(en.position.x-inv.position.x)+abs(en.position.y-inv.position.y))<=scope) {
                int spdhurt =  ((inv.acume*2+inv.maxacume)/3 - en.acume/2)/50 + inv.willingToFight-100+30;
                en.amountofjiqi -= spdhurt;
                int acumecost = MIN(500, inv.acume/10);
                inv.acume-=acumecost;
            }
        }
        }
    }
    
    
}
@end
