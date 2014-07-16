//
//  Enemy.h
//  Ennuma
//
//  Created by ennuma on 14-6-28.
//  Copyright 2014年 ennuma. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Enemy : CCSprite {
    
}
+(Enemy*) enemyWithType:(NSString*) type;
@end
