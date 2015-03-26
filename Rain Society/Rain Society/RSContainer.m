//
//  RSContainer.m
//  Rain Society
//
//  Created by Jucelio Fonseca on 26/03/15.
//  Copyright (c) 2015 Jucelio Fonseca. All rights reserved.
//

#import "RSContainer.h"

@implementation RSContainer

+(id)initWithSize:(CGRect)size{
    
    RSContainer* container = [[RSContainer alloc] init];
    [container setAnchorPoint:CGPointMake(0, 0)];
    [container setUserInteractionEnabled:true];
    [container setColor:[UIColor blueColor]];
    
    return container;
}
@end
