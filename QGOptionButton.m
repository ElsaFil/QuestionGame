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
//    [self.titleLabel setTextColor:[UIColor blackColor]];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    if (_isSelected){
        [self setBackgroundColor:[UIColor greenColor]];
        [self.titleLabel setTextColor:[UIColor blackColor]];
    }
    else {
        [self setBackgroundColor:[UIColor magentaColor]];
        [self.titleLabel setTextColor:[UIColor whiteColor]];
    }
    
}

@end
