//
//  QGOpenTriviaManager.m
//  QuestionGame
//
//  Created by Elsa Filippidou on 04/03/2017.
//  Copyright © 2017 allilo. All rights reserved.
//

#import "QGOpenTriviaManager.h"

NSString *baseURL = @"https://www.opentdb.com/api.php?";

@implementation QGOpenTriviaManager

- (void)getQuestionsForCategory:(QGCategories)category numberOfQuestions:(NSInteger)count difficulty:(QGDifficulty)difficulty type:(QGAnswerType)type encoding:(QGEncoding)encoding
{
    // TODO implement REST call and use result to populate the model
}

@end
