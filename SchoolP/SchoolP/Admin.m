#import "Admin.h"
#import "Menu.h"

@implementation Admin 
{
    NSMutableArray *courses;
}

@synthesize firstName = _firstName;
@synthesize lastName = _lastName;
@synthesize mailAddress = _mailAddress;
@synthesize phoneNumber = _phoneNumber;
//@synthesize courses = _courses;

+(id) adminWithName: (NSString *)name
           lastName: (NSString *)lastName
        mailAddress: (NSString *)mailAddress
        phoneNumber: (NSString *)phoneNumber
            courses: (NSArray *)coursesTemp {
    return [[self alloc]initWithAdminName:name
                                 lastName:lastName
                              mailAddress:mailAddress 
                              phoneNumber:phoneNumber
                                  courses:coursesTemp];
}

-(id)init {
    return [self initWithAdminName:@"unknown"
                          lastName:@"unknown"
                       mailAddress:@"unknown"
                       phoneNumber:@"0"
                           courses:0];
}

-(id) initWithAdminName: (NSString *)name
               lastName: (NSString *)lastName
            mailAddress: (NSString *)mailAddress
            phoneNumber: (NSString *)phoneNumber
                courses: (NSArray *)coursesTemp {
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

-(void) sendMessageToStudentWithMailAdress: (NSString *)mail {
    //Skickar meddelande till adressen angiven i "mail" variabeln.
}

-(void) sendMessageToStudents:(NSString *)mail {
    //Samma som ovan, fast alla mail i en array/dictionary
}

-(void)addNewScheduleForCourse:(NSString *)course
                   teacherName:(NSString *)name
                           day:(NSString *)day
                          time:(NSNumber *)time {}

-(void)editSchedule:(NSString *)schedule
                day:(NSString *)day
               time:(NSNumber *)time {}

-(NSMutableArray *)courses {
    return courses;
}

-(NSString *)description {
    return [NSString stringWithFormat:@"Name: %@, %@, Mail: %@, Phone: %@, Courses: %@",
            self.firstName,
            self.lastName,
            self.mailAddress,
            self.phoneNumber,
                [courses componentsJoinedByString:@", "]];
}
@end
