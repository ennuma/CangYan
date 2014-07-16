//
//  Soldier.h
//  Ennuma
//
//  Created by ennuma on 14-6-26.
//  Copyright 2014年 ennuma. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Hero.h"

@interface Soldier : CCSprite {
    //may need a list of soldiers and keep track of the current number of soldier to form arrangement
    //take time and believe in yourself
    Hero *__unsafe_unretained _hero;
}
+(Soldier*)SoldierWithHero:(Hero*)hero;
-(void)addSoldier;

@property(nonatomic,readwrite,unsafe_unretained) Hero* hero;
@end
