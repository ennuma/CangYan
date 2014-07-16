//
//  SoldierCache.h
//  Ennuma
//
//  Created by ennuma on 14-6-26.
//  Copyright 2014年 ennuma. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface SoldierCache : CCNode {
    //may need a list of soldiers and keep track of the current number of soldier to form arrangement
    //take time and believe in yourself
    CCNode *__unsafe_unretained _hero;
}
+(SoldierCache*)createCacheWithHero:(CCNode*)hero;
-(void)addSoldier;

@property(nonatomic,readwrite,unsafe_unretained) CCNode* hero;
@end
