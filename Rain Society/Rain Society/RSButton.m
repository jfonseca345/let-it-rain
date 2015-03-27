//
//  RSButton.m
//  Rain Society
//
//  Created by Jucelio Fonseca on 26/03/15.
//  Copyright (c) 2015 Jucelio Fonseca. All rights reserved.
//

#import "RSButton.h"


@interface RSButton()
@end

@implementation RSButton

-(id)init{
    SKLabelNode* buttonText;
    self = [super init];
    buttonText = [[SKLabelNode alloc ]init ];
    [buttonText setFontName:@"Verdana"];
    [buttonText setText:@" "];
    [buttonText setName:@"label"];
    //[buttonText setFontSize:100];
    [self setSize:CGSizeMake(buttonText.frame.size.width*1.75,buttonText.frame.size.height*1.75)];
    [buttonText setPosition:CGPointMake(0, 0)];
    [self addChild:buttonText];
    
    return self;
}

-(id)initWithText:(NSString *)text{
    SKLabelNode* buttonText;
    RSButton* button = [[RSButton alloc] init];
    buttonText = [[SKLabelNode alloc ]init ];
    [buttonText setFontName:@"Verdana"];
    [button setName:text];
    [buttonText setText:text];
    [buttonText setName:@"label"];
    //[buttonText setFontSize:100];
    [button setSize:CGSizeMake(buttonText.frame.size.width*1.75,buttonText.frame.size.height*1.75)];
    [buttonText setPosition:CGPointMake(CGRectGetMidX(button.frame), CGRectGetMidY(button.frame))];
    [button addChild:buttonText];
    
    return button;
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    self.handler();
}

-(void) setText: (NSString*) text{
    SKLabelNode *label = [self getLabel];
    [label setText:text];
    [self setName:text];
    [self setSize:CGSizeMake(label.frame.size.width*1.5,label.frame.size.height*1.5)];
    
}

-(SKLabelNode* )getLabel{
    return (SKLabelNode*)[self childNodeWithName:@"label"];
}

@end
