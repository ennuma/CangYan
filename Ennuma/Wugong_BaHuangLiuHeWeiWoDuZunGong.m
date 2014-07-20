//
//  Wugong_BaHuangLiuHeWeiWoDuZunGong.m
//  Ennuma
//
//  Created by ennuma on 14-7-19.
//  Copyright 2014年 ennuma. All rights reserved.
//
/**
 【八荒六合功】能力解说：
 加力威力：1000--1100
 护体威力：1200--1400
 一般特效：
 被破防后追加的普通攻击伤害杀集气值减少75%
 主功体特效：
 完全消除被破防后追加的普通攻击伤害杀集气值
 选择防御时所受伤害和降集气值减少三分之二 //TODO
 集气速度提升2点
 主功体加成武功
 『天山六阳掌』武功威力提升500
 『天山折梅手』功体加力时追加伤害70点
 **/
#import "Wugong_BaHuangLiuHeWeiWoDuZunGong.h"


@implementation Wugong_BaHuangLiuHeWeiWoDuZunGong


-(void)initWugongDamageForEachLevelAndQigongValue
{
    _neigongHuTi = 1050;
    _neigongJiaLi = 1300;
}
-(void)initWugongNameAndLevelAndAcumeCost
{
    _wugongName = @"八荒六合唯我独尊功";
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
        if ([m_wugong isWugong:@"天山折梅手"]) {
            hurt += 70;
            //CCLOG(@"here");
        }
        
    }
    return hurt;
}

-(int)effectWugongDamage:(int)wugongDamage WithInvader:(NSObject *)invader WithWugong:(Wugong *)m_wugong
{
    NSAssert([invader isKindOfClass:[Invader class] ], @"nsobj is not invader");
    Invader* inv = (Invader*)invader;
    if ([inv.mainNeiGong isWugong:self.wugongName]) {
        if ([m_wugong isWugong:@"天山六阳掌"]) {
            wugongDamage += 500;
            //CCLOG(@"here");
        }
        
    }
    return wugongDamage;
}
//when defending
-(int)effectDefendDamageConvertToSpdHurt:(int)damageToSpdHurt WithInvader:(NSObject *)invader WithWugong:(Wugong *)m_wugong
{
    NSAssert([invader isKindOfClass:[Invader class] ], @"nsobj is not invader");
    Invader* inv = (Invader*)invader;
    if ([inv.mainNeiGong isWugong:self.wugongName]) {
        damageToSpdHurt = 0;
    }else{
        damageToSpdHurt *= 0.25;
    }
    //CCLOG(@"spdhurt: %i",damageToSpdHurt);
    return damageToSpdHurt;
}
//-(int)effectLifeHurtAfterCalculate:(int)hurt WithInvader:(NSObject*)invader WithWugong:(Wugong *)m_wugong{
//    NSAssert([invader isKindOfClass:[Invader class] ], @"nsobj is not invader");
//    Invader* inv = (Invader*)invader;
//    if ([inv.mainNeiGong isWugong:self.wugongName]) {
//    }
//    return hurt;
//}


@end
