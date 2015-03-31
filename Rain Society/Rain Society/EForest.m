//
//  EForest.m
//  Rain Society
//
//  Created by Jucelio Fonseca on 31/03/15.
//  Copyright (c) 2015 Jucelio Fonseca. All rights reserved.
//

#import "EForest.h"

@implementation EForest

-(id) initWithPosition: (CGPoint) position{
    self = [super initWithImageNamed:@"floresta"];
    self.zPosition = 0;
    [self setPosition:position];
    [self.physicsBody setDynamic:NO];
    return self;
}
@end
