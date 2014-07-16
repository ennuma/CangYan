//
//  ComponentHeroBody.h
//  Ennuma
//
//  Created by ennuma on 14-6-25.
//  Copyright 2014年 ennuma. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Hero.h"
@interface ComponentHeroBody : CCNode {
    Hero* _heroBody;
}

+(ComponentHeroBody*) component;
@property (nonatomic) Hero* heroBody;
@end
