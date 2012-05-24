#import "User.h"

@implementation User
{
NSMutableArray *coursesArray;
}

@synthesize firstName = _firstName;
@synthesize lastName = _lastName;
@synthesize mailAddress = _mailAddress;
@synthesize phoneNumber = _phoneNumber;
@synthesize password = _password;
@synthesize admin = _admin;
//@synthesize courses = _courses;

+(id) userWithName:(NSString *)name 
          lastName:(NSString *)lastName
          password:(NSString *)password
       mailAddress:(NSString *)mailAddress
       phoneNumber:(NSString *)phoneNumber
             admin: (NSString *)admin
           courses:(NSDictionary *)courses {
    return [[self alloc]initWithUseName:name
                               lastName:lastName
                               password:password
                            mailAddress:mailAddress
                            phoneNumber:phoneNumber 
                                  admin:admin
                                courses:courses];
}

-(id)init {
    return [self initWithUseName:nil 
                        lastName:nil 
                        password:nil 
                     mailAddress:nil 
                     phoneNumber:nil
                           admin:nil
                         courses:nil];
}

-(id) initWithUseName:(NSString *)name
             lastName:(NSString *)lastName
             password:(NSString *)password
          mailAddress:(NSString *)mailAddress
          phoneNumber:(NSString *)phoneNumber 
                admin: (NSString *)admin 
              courses:(NSDictionary *)courses {
    if(self = [super init])
    {
        coursesArray = [NSMutableArray array];
        for (NSDictionary *object in courses) {
            [coursesArray addObject:object];
        }
        _firstName = name;
        _lastName = lastName;
        _mailAddress = mailAddress;
        _phoneNumber = phoneNumber;
        _password = password;
        _admin = admin;
    }
    return self;
}

-(NSMutableArray *)courses {
    return coursesArray;
}

-(NSString *)description {
    return [NSString stringWithFormat:@"Name: %@, %@, Mail: %@, Phone: %@, Courses: %@, Password: %@ Admin: %@",
            self.firstName,
            self.lastName,
            self.mailAddress,
            self.phoneNumber,
            [coursesArray componentsJoinedByString:@", "],
            self.password,
            self.admin];
}

@end
