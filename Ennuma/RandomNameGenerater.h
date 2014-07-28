//
//  RandomNameGenerater.h
//  Ennuma
//
//  Created by Zhaoyang on 14-7-28.
//  Copyright (c) 2014年 Zhaoyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
@interface RandomNameGenerater : CCNode
{
}
+(RandomNameGenerater*)sharedRandomNameGenerator;
-(NSString*)generateName:(NSString*)male;
@end
