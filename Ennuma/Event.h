//
//  Event.h
//  Ennuma
//
//  Created by ennuma on 14-7-23.
//  Copyright 2014年 ennuma. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Event : CCNode {
    int stage;
    bool finish;
}
-(void)proceed;
@property bool done;
@end
