//
//  QGOptionButton.m
//  QuestionGame
//
//  Created by Elsa Filippidou on 04/03/2017.
//  Copyright © 2017 allilo. All rights reserved.
//

#import "QGOptionButton.h"

@implementation QGOptionButton


- (void)drawRect:(CGRect)rect
{
    // Drawing code
    
    [self.titleLabel setTextColor:[UIColor blackColor]];
}

- (void)setIsSelected:(BOOL)isSelected
{
    if (isSelected != _isSelected) {
        
        _isSelected = isSelected;
        
        if (isSelected){
            [self setBackgroundColor:[UIColor greenColor]];
        }
        else {
            [self setBackgroundColor:[UIColor magentaColor]];
        }
    }
}

@end
