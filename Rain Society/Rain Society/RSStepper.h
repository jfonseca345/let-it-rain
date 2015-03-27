//
//  RSStepper.h
//  GameZAM
//
//  Created by Jucelio Fonseca on 26/03/15.
//  Copyright (c) 2015 Jucelio Fonseca. All rights reserved.
//

#import "RSContainer.h"

@interface RSStepper : RSContainer

-(void) setButtonColor:(UIColor*) color;
-(void)setValueLabel:(int) value;
-(int) getValueLabel;
@end
