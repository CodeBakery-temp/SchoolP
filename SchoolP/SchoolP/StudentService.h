#import "Student.h"

@interface ServiceStudent : Student

+(id) studentsFromDictonary:(NSDictionary*) dictionary;
-(id) asDictionary;
//-(NSArray *) studentCourse;

@end