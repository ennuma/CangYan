//
//  ComponentSoldierCache.m
//  Ennuma
//
//  Created by ennuma on 14-6-26.
//  Copyright 2014年 ennuma. All rights reserved.
//

#import "ComponentSoldierCache.h"
#import "ComponentHeroBody.h"

@implementation ComponentSoldierCache
-(id) init
{
    self = [super init];
    if (! self) return nil;
    
    //init soldier array
    SoldierArray = [[NSMutableArray alloc]init];
    //init number of soldiers
    numberOfSoldiers = 0;
    
    return self;
}

+(ComponentSoldierCache*)component
{
    return [[self alloc]init];
}

-(BOOL)initWithParent:(CCNode *)parent
{
    soldierCache = [SoldierCache createCacheWithHero: parent];
    [self addChild:soldierCache];
    return YES;
}

-(BOOL)addSoldier
{
    //Assert First
    NSAssert([[self.parent getChildByName:kNameComponentHeroBody recursively:NO] isKindOfClass: [ComponentHeroBody class]],
             @"Not HeroBody Class in ComponentSoldierCahce->addSoldier");
    
    //retrieve herobody
    ComponentHeroBody* componentHeroBody = (ComponentHeroBody*)[self.parent getChildByName:kNameComponentHeroBody recursively:NO];
    
    //create soldier and add to array
    Soldier* soldier = [Soldier SoldierWithHero: componentHeroBody.heroBody];
    [SoldierArray addObject:soldier];
    
    //set soldier position
    [self setSoldierPosition:soldier];
    
    //add soldier to Entitiy contains components
    [self.parent addChild:soldier];
    
    //increment number of soldiers
    numberOfSoldiers += 1;
    
    return YES;
}

-(void) setSoldierPosition: (Soldier*) soldier
{
    if (numberOfSoldiers<45) {
        soldier.position = CGPointMake(self.parent.position.x+5*((numberOfSoldiers%9)-4), self.parent.position.y+5*((numberOfSoldiers/9))+15);
    }
    
}

-(void)dealloc
{
    SoldierArray=nil;
}

-(NSMutableArray*)getSoldierArray
{
    return SoldierArray;
}
@end
