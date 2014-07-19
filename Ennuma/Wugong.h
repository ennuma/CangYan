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
    NSMutableArray* _damage; //wugong damage, not applicable to qigong
    int _poisionIndex;
    int _bleedIndex;
    int _level;
    //the type of range, 1 is point, 2 is line, 3 is blocks around, 4 is chinese char 'mi'
    int _rangeType;
    
    NSString* _wugongType;
    int _acumeCost;
    NSString* _wugongName;
    
    int _qigongValue;
}

@property int range;
@property NSMutableArray* damage;
@property int poisionIndex;
@property int bleedIndex;
@property int rangeType;
@property int level;
@property int acumeCost;
@property NSString* wugongName;
@property NSString* wugongType;
@property int qigongValue;

-(void)initWugongNameAndTypeAndAcumeCost;
-(void)initPoisionAndBleed;
-(void)initRangeAndRangeType;
-(void)initWugongDamageForEachLevelAndQigongValue;
@end
