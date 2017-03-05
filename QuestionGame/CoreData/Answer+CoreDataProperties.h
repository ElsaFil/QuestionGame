//
//  Answer+CoreDataProperties.h
//  QuestionGame
//
//  Created by Elsa Filippidou on 05/03/2017.
//  Copyright © 2017 allilo. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "Answer+CoreDataClass.h"

NS_ASSUME_NONNULL_BEGIN

@interface Answer (CoreDataProperties)

+ (NSFetchRequest<Answer *> *)fetchRequest;

@property (nonatomic) BOOL isCorrect;
@property (nullable, nonatomic, copy) NSString *answerText;
@property (nullable, nonatomic, retain) Question *question;

@end

NS_ASSUME_NONNULL_END
