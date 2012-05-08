#import "Student.h"

@interface ServiceStudent : Student


+(id) studentsFromDictonary:(NSDictionary*) dictionary;

-(NSArray *) studentCourse;

-(id) asDictionary;





@end
