//
//  Question+CoreDataProperties.h
//  QuestionGame
//
//  Created by Elsa Filippidou on 05/03/2017.
//  Copyright © 2017 allilo. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "Question+CoreDataClass.h"

NS_ASSUME_NONNULL_BEGIN

@interface Question (CoreDataProperties)

+ (NSFetchRequest<Question *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *category;
@property (nullable, nonatomic, copy) NSString *type;
@property (nullable, nonatomic, copy) NSString *diffuculty;
@property (nullable, nonatomic, copy) NSString *questionText;
@property (nullable, nonatomic, retain) NSSet<Answer *> *answers;

@end

@interface Question (CoreDataGeneratedAccessors)

- (void)addAnswersObject:(Answer *)value;
- (void)removeAnswersObject:(Answer *)value;
- (void)addAnswers:(NSSet<Answer *> *)values;
- (void)removeAnswers:(NSSet<Answer *> *)values;

@end

NS_ASSUME_NONNULL_END
