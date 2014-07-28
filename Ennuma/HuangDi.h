//
//  HuangDi.h
//  Ennuma
//
//  Created by Zhaoyang on 14-7-27.
//  Copyright (c) 2014年 Zhaoyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
@interface HuangDi : CCNode
{
    int _tili;
    int _nianling;
    int _jiankang;
    int _kuaile;
    int _wuli;
    int _zhili;
    
    int _maxtili;
    int _maxnianling;
    int _maxjiankang;
    int _maxkuaile;
    int _maxwuli;
    int _maxzhili;
    
}
+(HuangDi*)sharedHuangDi;
@property int tili;
@property int nianling;
@property int jiankang;
@property int kuaile;
@property int wuli;
@property int zhili;
@property int maxtili;
@property int maxnianling;
@property int maxkuaile;
@property int maxjiankang;
@property int maxwuli;
@property int maxzhili;
@end
