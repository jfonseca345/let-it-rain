//
//  RSStepper.m
//  GameZAM
//
//  Created by Jucelio Fonseca on 26/03/15.
//  Copyright (c) 2015 Jucelio Fonseca. All rights reserved.
//

#import "RSStepper.h"
#import "RSButton.h"

@interface RSStepper()

@property (nonatomic) int value;


@end
@implementation RSStepper

-(id)init{
    SKLabelNode* textScore;
    RSButton* buttonPlus;
    RSButton* buttonMinus;
    self = [super init];
    self.value=0;
    
    buttonMinus = [[RSButton alloc] initWithText:@"-"];
    buttonPlus = [[RSButton alloc ]initWithText:@"+"];
    [buttonMinus setSize:buttonPlus.frame.size];
    textScore = [[SKLabelNode alloc]initWithFontNamed:@"Verdana"];
    [textScore setText:[NSString stringWithFormat:@"%d", self.value]];
    [self setSize:CGSizeMake(buttonPlus.frame.size.width*5., buttonPlus.size.height*2.)];
    [buttonMinus setPosition:CGPointMake(CGRectGetMinX(self.frame)+CGRectGetWidth(buttonPlus.frame)/2., 0)];
    [buttonPlus setPosition:CGPointMake(CGRectGetMaxX(self.frame)-CGRectGetWidth(buttonPlus.frame)/2., 0)];
    [textScore setPosition:CGPointMake(CGRectGetMidX(self.frame),CGRectGetMidY(self.frame))];
    
    [self addChild:buttonMinus];
    [self addChild:buttonPlus];
    [self addChild:textScore];
    
    return self;
}

-(void) setButtonColor:(UIColor *)color{
    RSButton* buttonMinus = (RSButton *)[self childNodeWithName:@"-"];
    RSButton* buttonPlus = (RSButton *)[self childNodeWithName:@"+"];
    [buttonMinus setColor:color];
    [buttonPlus setColor:color];

}
@end
