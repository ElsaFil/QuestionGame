//
//  Question+CoreDataProperties.m
//  QuestionGame
//
//  Created by Elsa Filippidou on 05/03/2017.
//  Copyright © 2017 allilo. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "Question+CoreDataProperties.h"

@implementation Question (CoreDataProperties)

+ (NSFetchRequest<Question *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Question"];
}

@dynamic category;
@dynamic type;
@dynamic diffuculty;
@dynamic questionText;
@dynamic answers;

@end
