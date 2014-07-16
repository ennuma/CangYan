//
//  Hero.m
//  Ennuma
//
//  Created by ennuma on 14-6-27.
//  Copyright 2014年 ennuma. All rights reserved.
//

#import "Hero.h"


@implementation Hero
@synthesize soldierActiveRange = _soldierActiveRange;
-(id)init
{
    self = [super init];
    if (!self) {
        return nil;
    }
    return self;
}

+(Hero*)hero
{
    //set the hero image
    Hero* returnVal =  [[self alloc] initWithImageNamed:@"Enemy1.png"];
    
    //set hero's soldiers move range
    returnVal.soldierActiveRange = 50;

    return returnVal;
}

@end
