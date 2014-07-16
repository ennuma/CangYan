//
//  Hero.h
//  Ennuma
//
//  Created by ennuma on 14-6-27.
//  Copyright 2014年 ennuma. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Hero : CCSprite {
    float _soldierActiveRange;
}
+(Hero*)hero;
@property (nonatomic,readwrite,assign) float soldierActiveRange;
@end
