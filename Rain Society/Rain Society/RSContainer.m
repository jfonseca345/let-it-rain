//
//  RSContainer.m
//  Rain Society
//
//  Created by Jucelio Fonseca on 26/03/15.
//  Copyright (c) 2015 Jucelio Fonseca. All rights reserved.
//

#import "RSContainer.h"

@implementation RSContainer

-(id)initWithColor:(UIColor*)color{
    
    self = [super init];
    [self setColor:color];
    return self;
}

-(id)init{
    self = [super init];
    [self setUserInteractionEnabled:YES];
    [self setSize:CGSizeMake(1, 1)];
    return self;
}
@end