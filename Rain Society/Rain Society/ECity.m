//
//  ECity.m
//  Rain Society
//
//  Created by Jucelio Fonseca on 31/03/15.
//  Copyright (c) 2015 Jucelio Fonseca. All rights reserved.
//

#import "ECity.h"

@implementation ECity

-(id) initWithPosition: (CGPoint) position{
    self = [super initWithImageNamed:@"cidade"];
    self.zPosition = 1;
    [self setPosition:position];
    [self.physicsBody setDynamic:NO];
    return self;
}
@end
