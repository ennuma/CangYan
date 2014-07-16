//
//  MessageCache.h
//  Ennuma
//
//  Created by ennuma on 14-6-27.
//  Copyright 2014年 ennuma. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface MessageCache : CCNode {
    NSMutableArray* _messages;
    int currentIndex;
}

+(MessageCache*) messageCacheWithMessages:(int) numberOfMessages;
-(CCSprite*)nextMessage;

@property (nonatomic,readwrite) NSMutableArray* messages;
@end
