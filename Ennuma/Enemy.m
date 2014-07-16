//
//  Enemy.m
//  Ennuma
//
//  Created by ennuma on 14-6-28.
//  Copyright 2014年 ennuma. All rights reserved.
//

#import "Enemy.h"
#import "Extension.h"
#import "ComponentHeroBody.h"
#import "ComponentAttackRange.h"
#import "ComponentSoldierCache.h"

@implementation Enemy
-(id)init
{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    
    return self;
}

+(Enemy*)enemyWithType:(NSString *)type
{
    Enemy* ret = [[self alloc] init];
    [ret prepareComponent];
    return ret;
}

-(void) prepareComponent
{
    /**
     Add components to the current player
     */
    
    //herobody
    ComponentHeroBody* CHB = [ComponentHeroBody component];
    [self addChild:CHB z:0 name:kNameComponentHeroBody];
    self.contentSize = CGSizeMake(CHB.heroBody.soldierActiveRange+CHB.heroBody.contentSize.width, CHB.heroBody.soldierActiveRange+CHB.heroBody.contentSize.height);
    //attack range
    /**
     ComponentAttackRange* CAR = [ComponentAttackRange component];
     [self addChild:CAR z:0 name:kNameComponentAttackRange];
     [CAR reset];
     **/
    
    //soldier cache
    ComponentSoldierCache* SC   =[ComponentSoldierCache component];
    [self addChild:SC z:0 name:kNameComponentSoldierCache];
    [SC initWithParent:self];
    
    //retrieve soldier cache
    SoldierCache* soldierCache = (SoldierCache*)[self getChildByName:kNameComponentSoldierCache recursively:NO];
    for(int i = 0 ; i < 36 ; i++){
        [soldierCache addSoldier];
    }
}

@end
