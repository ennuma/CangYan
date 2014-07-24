//
//  Special_LingHuChong.m
//  Ennuma
//
//  Created by ennuma on 14-7-24.
//  Copyright 2014年 ennuma. All rights reserved.
//
/**
 战斗中移动力提升3格；进入战斗时初始集气MAX(受攻击发动破X式减伤20%？）
 **/
#import "Special_LingHuChong.h"


@implementation Special_LingHuChong
-(int)effectInitAmountJiqi:(int)jiqi WithInvader:(NSObject *)invader WithWugong:(Wugong *)m_wugong
{
    jiqi+=1000;
    return jiqi;
}
-(int)effectMoveNumberBeforeAction:(int)movenum WithInvader:(NSObject *)invader
{
    return movenum+3;
}
-(int)effectLifeHurtAfterCalculate:(int)hurt WithDef:(NSObject *)def WithWugong:(Wugong *)m_wugong
{
    NSAssert([def isKindOfClass:[Invader class] ], @"nsobj is not invader");
    Invader* inv = (Invader*)def;
    hurt*=0.8;
    [inv say:@"破剑式减伤" WithColor:[CCColor colorWithCcColor3b:ccGREEN]];
    return hurt;
}

@end
