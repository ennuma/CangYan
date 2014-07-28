//
//  RandomGuanYuanGenerater.h
//  Ennuma
//
//  Created by Zhaoyang on 14-7-28.
//  Copyright (c) 2014年 Zhaoyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GuanYuan.h"
@interface RandomGuanYuanGenerater : CCNode
{
}
+(RandomGuanYuanGenerater*)sharedRandomGuanYuanGenerator;
-(GuanYuan*)generateGuanYuan;
@end
