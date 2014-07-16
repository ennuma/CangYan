//
//  ComponentAttackRange.h
//  Ennuma
//
//  Created by ennuma on 14-6-26.
//  Copyright 2014年 ennuma. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface ComponentAttackRange : CCNode {
    CCSprite* range;
}

+(ComponentAttackRange*)component;
-(void) reset;
@end
