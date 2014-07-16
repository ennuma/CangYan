//
//  EnemyCache.m
//  Ennuma
//
//  Created by ennuma on 14-6-28.
//  Copyright 2014年 ennuma. All rights reserved.
//

#import "EnemyCache.h"


@implementation EnemyCache
@synthesize enemyArray=_enemyArray;
int enemyNumberMAX = 5;
static int currentIndex;
-(id)init
{
    self = [super init];
    if (!self) {
        return nil;
    }
    _enemyArray = [[NSMutableArray alloc]init];
    currentIndex = 0;
    for (int i = 0 ; i < enemyNumberMAX; i++) {
        Enemy* em = [Enemy enemyWithType:@"nil"];
        em.visible = NO;
        [_enemyArray addObject:em];
        //CCLOG(@"%i",[_enemyArray count]);
        [self addChild:em];
    }
    
    return self;
}
+(EnemyCache*)enemyCache
{
    EnemyCache* ret = [[self alloc] init];
    return ret;
}

-(Enemy*)nextEnemy
{
    int index = currentIndex;
    currentIndex+=1;
    if (currentIndex == enemyNumberMAX) {
        currentIndex = 0;
    }
    //CCLOG(@"%i",[_enemyArray count]);
    Enemy* ret = [_enemyArray objectAtIndex:index];
    NSAssert(ret!=nil, @"next enemy is nil");
    ret.visible = YES;
    return ret;
}

-(void)dealloc
{
    _enemyArray = nil;
}
@end
