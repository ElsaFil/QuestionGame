//
//  QGOptionButton.h
//  QuestionGame
//
//  Created by Elsa Filippidou on 04/03/2017.
//  Copyright © 2017 allilo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM (NSUInteger,QGOptionButtonType) {
    QGOptionButtonTypeCategory = 0,
    QGOptionButtonTypeDifficulty
};

@interface QGOptionButton : UIButton

@property (nonatomic, assign) BOOL isSelected;
@property (nonatomic, assign) QGOptionButtonType type;

@end
