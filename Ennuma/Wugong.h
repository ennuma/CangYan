//
//  Wugong.h
//  Ennuma
//
//  Created by ennuma on 14-7-14.
//  Copyright 2014年 ennuma. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Wugong : CCNode {
    int _range;
    int _damage;
    int _poisionIndex;
    int _bleedIndex;
    int _level;
    //the type of range, 1 is point, 2 is line, 3 is blocks around, 4 is chinese char 'mi'
    int _rangeType;
}

@property int range;
@property int damage;
@property int poisionIndex;
@property int bleedIndex;
@property int rangeType;
@property int level;
@end
