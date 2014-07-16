//
//  ComponentSoldierCache.h
//  Ennuma
//
//  Created by ennuma on 14-6-26.
//  Copyright 2014年 ennuma. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Extension.h"
#import "SoldierCache.h"
#import "Soldier.h"
@interface ComponentSoldierCache : CCNode {
    SoldierCache* soldierCache;
    int numberOfSoldiers;
    NSMutableArray* SoldierArray;
}

+(ComponentSoldierCache*)component;
//-(void) reset;
-(BOOL) initWithParent:(CCNode*) parent;
-(BOOL) addSoldier;
-(NSMutableArray*)getSoldierArray;
@end
