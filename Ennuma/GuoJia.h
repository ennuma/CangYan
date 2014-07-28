//
//  GuoJia.h
//  Ennuma
//
//  Created by Zhaoyang on 14-7-28.
//  Copyright (c) 2014年 Zhaoyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
@interface GuoJia : CCNode
{
    NSMutableDictionary* guojiaDic;
}
+(GuoJia*)sharedGuoJia;
@end
