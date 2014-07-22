//
//  Wugong_ShengHuoShenGong.m
//  Ennuma
//
//  Created by ennuma on 14-7-21.
//  Copyright 2014年 ennuma. All rights reserved.
//
/**
 【圣火神功】能力解说：
 加力威力：900--1000
 护体威力：850--950
 一般特效：
 初始集气提升200点
 人物集气速度提升1点
 如行动前未移动，可在行动后获得一次移动机会
 主功体特效：
 初始集气提升400点
 人物集气速度提升3点
 无论行动前是否移动，可在行动后获得一次移动机会
 主功体加成武功：
 『蛇鹤八打』功体加力时追加杀集气100点
 『狂风刀法』人物行动后集气恢复200点

 **/
#import "Wugong_ShengHuoShenGong.h"


@implementation Wugong_ShengHuoShenGong
-(void)initWugongDamageForEachLevelAndQigongValue
{
    _neigongHuTi = 950;
    _neigongJiaLi = 900;
}

-(void)initWugongNameAndLevelAndAcumeCost
{
    _wugongName = @"圣火神功";
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
        inv.amountofjiqi += 3;
    }else{
        inv.amountofjiqi += 1;
    }

}
-(int)effectInitAmountJiqi:(int)jiqi WithInvader:(NSObject *)invader WithWugong:(Wugong *)m_wugong
{
    
    NSAssert([invader isKindOfClass:[Invader class] ], @"nsobj is not invader");
    Invader* inv = (Invader*)invader;
    
    if ([inv.mainNeiGong isWugong:self.wugongName]) {
        jiqi+=400;
    }else{
        jiqi +=200;
    }
    return jiqi;
}
-(int)effectRestoreJiQi:(int)jiqi AfterAttackWithInvader:(NSObject *)invader WithWugong:(Wugong *)m_wugong
{
    NSAssert([invader isKindOfClass:[Invader class] ], @"nsobj is not invader");
    Invader* inv = (Invader*)invader;
    
    if ([inv.mainNeiGong isWugong:self.wugongName]) {
        if ([m_wugong isWugong:@"狂风刀法"]) {
            jiqi+=200;
        }
    }
    return jiqi;
}
-(int)effectNeiGongJiaLiSpdHurt:(int)spdhurt WithInvader:(NSObject *)invader WithWugong:(Wugong *)m_wugong
{
    NSAssert([invader isKindOfClass:[Invader class] ], @"nsobj is not invader");
    Invader* inv = (Invader*)invader;
    
    if ([inv.mainNeiGong isWugong:self.wugongName]) {
        if ([m_wugong isWugong:@"蛇鹤八打"]) {
            spdhurt += 100;
        }
    }
    
    return spdhurt;
}

@end
