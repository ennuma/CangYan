//
//  Wugong_TaiXuanShenGong.m
//  Ennuma
//
//  Created by ennuma on 14-7-21.
//  Copyright 2014年 ennuma. All rights reserved.
//
/**
 【太玄神功】能力解说：
 加力威力：1200--1400
 护体威力：1100--1350
 一般特效：
 攻击时造成的敌方怒气下降15//上升值变为原有值的50%
 人物集气速度提升1点
 主功体特效：
 攻击时不会造成敌方怒下降30//气值上升
 人物集气速度提升4点
 人物战意提升速度增加25%
 主功体加成武功：
 『逍遥游』人物行动后恢复集气值300点
 『三分剑术』功体加力时降低对手战意1点//TODO
 『南山刀法』功体加力时追加伤害60点
 『海叟钓法』功体加力时追加杀集气200点

 **/
#import "Wugong_TaiXuanShenGong.h"


@implementation Wugong_TaiXuanShenGong
-(void)initWugongDamageForEachLevelAndQigongValue
{
    _neigongHuTi = 1300;
    _neigongJiaLi = 1275;
}

-(void)initWugongNameAndLevelAndAcumeCost
{
    _wugongName = @"太玄神功";
    _level = 10;
}

-(bool)isNeiGong
{
    return true;
}
-(float)effectWillingToFight:(float)willingToFight WithInvader:(NSObject *)invader WithWugong:(Wugong *)m_wugong
{
    NSAssert([invader isKindOfClass:[Invader class] ], @"nsobj is not invader");
    Invader* inv = (Invader*)invader;
    
    if ([inv.mainNeiGong isWugong:self.wugongName]) {
        willingToFight*=1.25;
    }
    return willingToFight;
}

-(int)effectNeiGongJiaLiAngryHurt:(int)angry WithInvader:(NSObject *)invader WithWugong:(Wugong *)m_wugong
{
    NSAssert([invader isKindOfClass:[Invader class] ], @"nsobj is not invader");
    Invader* inv = (Invader*)invader;
    
    
    if ([inv.mainNeiGong isWugong:self.wugongName]) {
        angry += 30;
    }else{
        angry += 15;
    }
    
    return angry;
}
-(int)effectNeiGongJiaLiHurt:(int)hurt WithInvader:(NSObject *)invader WithWugong:(Wugong *)m_wugong
{
    NSAssert([invader isKindOfClass:[Invader class] ], @"nsobj is not invader");
    Invader* inv = (Invader*)invader;
    
    
    if ([inv.mainNeiGong isWugong:self.wugongName]) {
        if ([m_wugong isWugong:@"南山刀法"]) {
            hurt+=60;
        }
    }
    return hurt;
}
-(int)effectNeiGongJiaLiSpdHurt:(int)spdhurt WithInvader:(NSObject *)invader WithWugong:(Wugong *)m_wugong
{
    NSAssert([invader isKindOfClass:[Invader class] ], @"nsobj is not invader");
    Invader* inv = (Invader*)invader;
    
    
    if ([inv.mainNeiGong isWugong:self.wugongName]) {
        if ([m_wugong isWugong:@"海叟钓法"]) {
            spdhurt+=200;
        }
    }
    return spdhurt;
}
-(int)effectRestoreJiQi:(int)jiqi AfterAttackWithInvader:(NSObject *)invader WithWugong:(Wugong *)m_wugong
{
    NSAssert([invader isKindOfClass:[Invader class] ], @"nsobj is not invader");
    Invader* inv = (Invader*)invader;
    
    
    if ([inv.mainNeiGong isWugong:self.wugongName]) {
        if ([m_wugong isWugong:@"逍遥游"]) {
            jiqi+=300;
        }
    }
    return jiqi;

}
-(void)effectInUpdateJiQi:(NSObject *)invader
{
    NSAssert([invader isKindOfClass:[Invader class] ], @"nsobj is not invader");
    Invader* inv = (Invader*)invader;
    
    if ([inv.mainNeiGong isWugong:self.wugongName]) {
        inv.amountofjiqi += 4;
    }else{
        inv.amountofjiqi += 1;
    }
    
}

@end
