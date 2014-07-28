//
//  XuanZheng.h
//  Ennuma
//
//  Created by Zhaoyang on 14-7-27.
//  Copyright (c) 2014年 Zhaoyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
@interface XuanZheng : CCScene
{
    CCSprite* exit;
    CGRect officier;
    CGRect people;
    CGRect custom;
    CGRect war;
    CGRect prison;
    CGRect build;
    
    CCLayoutBox* officierLayout;
    CCLayoutBox* peopleLayout;
    CCLayoutBox* customLayout;
    CCLayoutBox* warLayout;
    CCLayoutBox* prisonLayout;
    CCLayoutBox* buildLayout;
}
+(CCScene*)scene;
@end
