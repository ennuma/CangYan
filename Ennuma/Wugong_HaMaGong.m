//
//  Wugong_HaMaGong.m
//  Ennuma
//
//  Created by ennuma on 14-7-20.
//  Copyright 2014年 ennuma. All rights reserved.
//
/**
 【蛤蟆功】能力解说：
 加力威力：1100--1300
 护体威力：900--1100
 一般特效：
 被攻击时怒气上升值提升20% 
 行动后流血状态减少15点
 主功体特效：
 被攻击时怒气上升值提升40%
 行动后流血状态减少30点
 主功体加成武功：
 『白驼雪山掌』功体加力时追加杀集气200点
 『玄冥神掌』功体加力时追加中毒30点

 **/
#import "Wugong_HaMaGong.h"


@implementation Wugong_HaMaGong

-(void)initWugongDamageForEachLevelAndQigongValue
{
    _neigongHuTi = 1200;
    _neigongJiaLi = 1000;
}

-(void)initWugongNameAndLevelAndAcumeCost
{
    _wugongName = @"蛤蟆功";
    _level = 10;
}

-(bool)isNeiGong
{
    return true;
}


-(int)effectNeiGongJiaLiSpdHurt:(int)spdhurt WithInvader:(NSObject *)invader WithWugong:(Wugong *)m_wugong
{
    NSAssert([invader isKindOfClass:[Invader class] ], @"nsobj is not invader");
    Invader* inv = (Invader*)invader;
    
    if ([inv.mainNeiGong isWugong:self.wugongName]) {
        if ([m_wugong isWugong:@"白驼山神掌"]) {
            spdhurt += 150;
            //CCLOG(@"here");
        }
        
    }
    
    return spdhurt;
    
}
-(void)effectAfterAction:(NSObject *)invader
{
    NSAssert([invader isKindOfClass:[Invader class] ], @"nsobj is not invader");
    Invader* inv = (Invader*)invader;
    if ([inv.mainNeiGong isWugong:self.wugongName]) {
        inv.liuXue -= 30;
        if (inv.liuXue<0) {
            inv.liuXue = 0;
        }
    }else{
        inv.liuXue -= 15;
        if (inv.liuXue<0) {
            inv.liuXue = 0;
        }
    }
}

-(int)effectNeiGongJiaLiPoisionHurt:(int)poisionnum WithInvader:(NSObject *)invader WithWugong:(Wugong *)m_wugong
{
    
    NSAssert([invader isKindOfClass:[Invader class] ], @"nsobj is not invader");
    Invader* inv = (Invader*)invader;
    if ([inv.mainNeiGong isWugong:self.wugongName]) {
        if ([m_wugong isWugong:@"玄冥神掌"]) {
            poisionnum += 30;
        }
    }
    return poisionnum;
}

-(int)effectAngryRateAfterBeingAttacked:(int)angryRate WithInvader:(NSObject *)invader WithWugong:(Wugong *)m_wugong
{
    NSAssert([invader isKindOfClass:[Invader class] ], @"nsobj is not invader");
    Invader* inv = (Invader*)invader;
    if ([inv.mainNeiGong isWugong:self.wugongName]) {
        angryRate*=1.4;
    }else{
        angryRate *=1.2;
    }
    
    return angryRate;
}

@end
