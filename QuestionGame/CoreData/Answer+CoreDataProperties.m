//
//  Answer+CoreDataProperties.m
//  QuestionGame
//
//  Created by Elsa Filippidou on 05/03/2017.
//  Copyright © 2017 allilo. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "Answer+CoreDataProperties.h"

@implementation Answer (CoreDataProperties)

+ (NSFetchRequest<Answer *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Answer"];
}

@dynamic isCorrect;
@dynamic answerText;
@dynamic question;

@end
