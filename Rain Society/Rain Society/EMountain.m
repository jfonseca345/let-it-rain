//
//  EMountain.m
//  Rain Society
//
//  Created by Jucelio Fonseca on 31/03/15.
//  Copyright (c) 2015 Jucelio Fonseca. All rights reserved.
//

#import "EMountain.h"

@implementation EMountain

-(id) initWithPosition: (CGPoint) position{
    self = [super initWithImageNamed:@"montanha"];
    self.zPosition = 0;
    [self setPosition:position];
    [self.physicsBody setDynamic:NO];
    [self setZPosition:1];
    return self;
}
@end
