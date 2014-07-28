//
//  RandomFeiZiGenerator.h
//  Ennuma
//
//  Created by Zhaoyang on 14-7-27.
//  Copyright (c) 2014年 Zhaoyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "FeiZi.h"
@interface RandomFeiZiGenerator : CCNode
{
}
+(RandomFeiZiGenerator*)sharedRandomFeiZiGenerator;
-(FeiZi*)generateFeiZi;
@end
