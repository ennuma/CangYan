//
//  Wugong_ZiXiaShenGong.m
//  Ennuma
//
//  Created by ennuma on 14-7-22.
//  Copyright 2014年 ennuma. All rights reserved.
//
/**
 【紫霞神功】能力解说：
 加力威力：800--950
 护体威力：850--1000
 一般特效：
 行动后恢复消耗内力值的15%
 每5时序恢复一点内伤（如内伤在50以上成功几率为50%）
 主功体特效：
 行动后恢复消耗内力值的30%
 每3时序恢复一点内伤（无视内伤程度必定成功）
 主功体加成武功：
 『太岳三青峰』必定连击 15%几率三连击
 『两仪剑法』武功威力提升500
 **/
#import "Wugong_ZiXiaShenGong.h"


@implementation Wugong_ZiXiaShenGong
-(void)initWugongDamageForEachLevelAndQigongValue
{
    _neigongHuTi = 875;
    _neigongJiaLi = 925;
    time = 0;
}

-(void)initWugongNameAndLevelAndAcumeCost
{
    _wugongName = @"紫霞神功";
    _level = 10;
}

-(bool)isNeiGong
{
    return true;
}
-(int)effectLifeHurtAfterCalculate:(int)hurt WithAtk:(NSObject *)atk WithWugong:(Wugong *)m_wugong
{
    NSAssert([atk isKindOfClass:[Invader class] ], @"nsobj is not invader");
    Invader* inv = (Invader*)atk;
    
    if ([inv.mainNeiGong isWugong:self.wugongName]) {
        if ([m_wugong isWugong:@"太岳三青峰"]) {
            if (CCRANDOM_0_1()*100<15) {
                hurt*=2.4; //3 hits
            }else{
                hurt*=1.7;
            }
        }
    }
    return hurt;
}
-(int)effectWugongDamage:(int)wugongDamage WithInvader:(NSObject *)invader WithWugong:(Wugong *)m_wugong
{
    NSAssert([invader isKindOfClass:[Invader class] ], @"nsobj is not invader");
    Invader* inv = (Invader*)invader;
    
    if ([inv.mainNeiGong isWugong:self.wugongName]) {
        if ([m_wugong isWugong:@"两仪剑法"]) {
            wugongDamage+=500;
        }
    }
    return wugongDamage;
}
-(void)effectInUpdateJiQi:(NSObject *)invader
{
    NSAssert([invader isKindOfClass:[Invader class] ], @"nsobj is not invader");
    Invader* inv = (Invader*)invader;
    
    time+=1;
    int bound = 0;
    if ([inv.mainNeiGong isWugong:self.wugongName]) {
        bound = 3;
        if (time>=bound) {
            inv.bleed -=1;
            if (inv.bleed<0) {
                inv.bleed = 0;
            }
            time = 0;
        }
        
    }else{
        bound = 5;
        if (time>=bound) {
            if (inv.bleed>50) {
                if (CCRANDOM_0_1()*100<50) {
                    time = 0;
                    return;
                }
            }
            inv.bleed -=1;
            if (inv.bleed<0) {
                inv.bleed = 0;
            }
            time = 0;
        }
        
    }
}

-(void)effectRestoreAfterActionWithInvader:(NSObject *)invader
{
    NSAssert([invader isKindOfClass:[Invader class] ], @"nsobj is not invader");
    Invader* inv = (Invader*)invader;
    
    if ([inv.mainNeiGong isWugong:self.wugongName]) {
        int restoreAcume = (inv.maxacume - inv.acume)*0.30;
        inv.acume+=restoreAcume;
    }else{
        int restoreAcume = (inv.maxacume - inv.acume)*0.15;
        inv.acume+=restoreAcume;
    }

}

@end
