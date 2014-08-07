//
//  DiaoHuanGuanYuan.h
//  Ennuma
//
//  Created by Zhaoyang on 14-8-7.
//  Copyright (c) 2014年 Zhaoyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "cocos2d-ui.h"
@interface DiaoHuanGuanYuan : CCScene
{
    CGPoint lastTouch;
    CCLayoutBox* layout;
}
+(DiaoHuanGuanYuan*)sharedScene;
@end
