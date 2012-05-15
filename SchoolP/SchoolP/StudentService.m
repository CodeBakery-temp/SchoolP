#import "StudentService.h"

@implementation ServiceStudent {
    NSMutableDictionary *allCourses;
    // NSMutableDictionary *allStudents;
    
}

+(id) studentsFromDictonary:(NSDictionary*) dictionary {
    return [self studentWithName:[dictionary valueForKey:@"name"]
                        lastName:[dictionary valueForKey:@"lastname"]
                     mailAddress:[dictionary valueForKey:@"mailaddress"]
                     phoneNumber:[dictionary valueForKey:@"phonenumber"]
                         courses:[dictionary valueForKey:@"courses"]];
}

-(id) asDictionary {
    return [NSDictionary dictionaryWithObjectsAndKeys:
            self.firstName, @"name", 
            self.lastName, @"lastname", 
            self.mailAddress, @"mailaddress", 
            self.phoneNumber, @"phonenumber",
            nil];
}

//-(NSArray *) studentCourse {
//    
//    NSSortDescriptor *byCourse = [NSSortDescriptor sortDescriptorWithKey:@"course" ascending:NO];
//
//    NSMutableArray *courses = [NSMutableArray array];
////    NSMutableArray *students = [NSMutableArray array];                            //couchDB
//    [courses addObjectsFromArray:[NSArray  arrayWithArray:[allCourses objectForKey:students]];
////    [students addObjectsFromArray:[NSArray arrayWithArray:[allStudents objectForKey:courses]];
//      
//    return [courses sortedArrayUsingDescriptors:[NSArray arrayWithObject:byCourse]];
//
//}

@end
