//
//  SoldierCache.m
//  Ennuma
//
//  Created by ennuma on 14-6-26.
//  Copyright 2014年 ennuma. All rights reserved.
//

#import "SoldierCache.h"


@implementation SoldierCache
@synthesize hero=_hero;
-(id)init
{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    return self;
}

+(SoldierCache*)createCacheWithHero:(CCNode*)hero
{
    
    SoldierCache* returnVal =  [[self alloc]init];
    returnVal.hero = hero;
    return returnVal;
}

//TODO
-(void)addSoldier
{
    CCLOG(@"add soldier");
    CCLOG(@"%@",_hero);
}
@end
