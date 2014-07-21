//
//  Wugong_HunYuanGong.m
//  Ennuma
//
//  Created by ennuma on 14-7-20.
//  Copyright 2014年 ennuma. All rights reserved.
//
/**
 【混元功】能力解说：
 加力威力：800--900
 护体威力：850--950
 一般特效：
 每6时序恢复1点体力，行动后恢复3点体力
 行动后恢复50点内力
 主功体特效：
 每3时序恢复1点体力，行动后恢复6点体力
 行动后恢复150点内力
 主功体加成武功：
 『金蛇剑法』必定暴击 
 『反两仪刀法』武功威力提升400
 **/

#import "Wugong_HunYuanGong.h"


@implementation Wugong_HunYuanGong

-(void)initWugongDamageForEachLevelAndQigongValue
{
    _neigongHuTi = 850;
    _neigongJiaLi = 900;
    time = 0;
}

-(void)initWugongNameAndLevelAndAcumeCost
{
    _wugongName = @"混元功";
    _level = 10;
}

-(bool)isNeiGong
{
    return true;
}


-(int)effectWugongDamage:(int)wugongDamage WithInvader:(NSObject *)invader WithWugong:(Wugong *)m_wugong
{
    NSAssert([invader isKindOfClass:[Invader class] ], @"nsobj is not invader");
    Invader* inv = (Invader*)invader;
    
    if ([inv.mainNeiGong isWugong:self.wugongName]) {
        if ([m_wugong isWugong:@"反两仪刀法"]) {
            wugongDamage+=400;
            //CCLOG(@"here");
        }
        
    }
    
    return wugongDamage;
    
}
-(void)effectAfterAction:(NSObject *)invader
{
    NSAssert([invader isKindOfClass:[Invader class] ], @"nsobj is not invader");
    Invader* inv = (Invader*)invader;
    if ([inv.mainNeiGong isWugong:self.wugongName]) {
        inv.acume+=150;
        if (inv.acume > inv.maxacume) {
            inv.acume = inv.maxacume;
        }
        
        inv.stamina += 6;
        if (inv.stamina>100) {
            inv.stamina = 100;
        }
    }else{
        inv.acume+=50;
        if (inv.acume > inv.maxacume) {
            inv.acume = inv.maxacume;
        }
        
        inv.stamina += 3;
        if (inv.stamina>100) {
            inv.stamina = 100;
        }
    }
}
-(void)effectInUpdateJiQi:(NSObject *)invader
{
    NSAssert([invader isKindOfClass:[Invader class] ], @"nsobj is not invader");
    Invader* inv = (Invader*)invader;
    time+=1;
    
    int bound = 0;
    if ([inv.mainNeiGong isWugong:self.wugongName]) {
        bound = 3;
    }else{
        bound = 6;
    }
    
    if (time>=bound) {
        inv.stamina +=1;
        if (inv.stamina>100) {
            inv.stamina = 100;
        }
        time = 0;
    }

}

-(int)effectBaojiRate:(int)baojirate WithInvader:(NSObject *)invader WithWugong:(Wugong *)m_wugong
{
    NSAssert([invader isKindOfClass:[Invader class] ], @"nsobj is not invader");
    Invader* inv = (Invader*)invader;
    
    if ([inv.mainNeiGong isWugong:self.wugongName]) {
        if ([m_wugong isWugong:@"金蛇剑法"]) {
            baojirate = 100;
            //CCLOG(@"here");
        }
        
    }
    
    return baojirate;

}
@end
