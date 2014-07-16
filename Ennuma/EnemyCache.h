//
//  EnemyCache.h
//  Ennuma
//
//  Created by ennuma on 14-6-28.
//  Copyright 2014年 ennuma. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Enemy.h"
@interface EnemyCache : CCNode {
    NSMutableArray* _enemyArray;
}

+(EnemyCache*)enemyCache;
-(Enemy*)nextEnemy;
@property (nonatomic,readwrite) NSMutableArray* enemyArray;
@end
