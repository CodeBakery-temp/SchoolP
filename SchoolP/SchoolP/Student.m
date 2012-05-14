#import "Student.h"

@implementation Student
{
    NSMutableArray *courses;
}

@synthesize firstName = _firstName;
@synthesize lastName = _lastName;
@synthesize mailAddress = _mailAddress;
@synthesize phoneNumber = _phoneNumber;
//@synthesize courses = _courses;

+(id) studentWithName: (NSString *)name lastName: (NSString *) lastName mailAddress: (NSString *)mailAddress phoneNumber:(NSString *)phoneNumber courses: (NSDictionary *) coursesTemp {
    return [[self alloc]initWithStudentName:name lastName:lastName mailAddress:mailAddress phoneNumber:phoneNumber courses:coursesTemp];
}

-(id)init {
    return [self initWithStudentName:@"unknown" lastName: @"unknown"  mailAddress:@"unknown" phoneNumber:@"0" courses:0];
}

-(id) initWithStudentName: (NSString *)name lastName: (NSString *) lastName mailAddress: (NSString *)mailAddress phoneNumber:(NSString *)phoneNumber courses: (NSDictionary *) coursesTemp {
    if(self = [super init])
    {
        courses = [NSMutableArray array];
        for (NSDictionary *object in coursesTemp) {
            [courses addObject:object];
        }
        _firstName = name;
        _lastName = lastName;
        _mailAddress = mailAddress;
        _phoneNumber = phoneNumber;
    }
    return self;
}

-(NSMutableArray *)courses {
    return courses;
}

-(NSString *)description {
    return [NSString stringWithFormat:@"Name: %@, %@, Mail: %@, Phone: %@, Courses: %@", self.firstName, self.lastName, self.mailAddress, self.phoneNumber, [courses componentsJoinedByString:@", "]];
}

@end