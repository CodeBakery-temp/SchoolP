#import <Foundation/Foundation.h>

@interface Student : NSObject

@property (nonatomic, copy) NSString *firstName;
@property (nonatomic, copy) NSString *lastName;
@property (nonatomic, copy) NSString *mailAddress;
@property (nonatomic, copy) NSString *phoneNumber;
//@property (nonatomic, copy) NSArray *courses;


+(id) studentWithName: (NSString *)name
             lastName: (NSString *)lastName
          mailAddress: (NSString *)mailAddress
          phoneNumber: (NSString *)phoneNumber
              courses: (NSDictionary *)courses;

-(id) initWithStudentName: (NSString *)name
                 lastName: (NSString *)lastName
              mailAddress: (NSString *)mailAddress
              phoneNumber: (NSString *)phoneNumber
                  courses: (NSDictionary *)courses;

-(NSMutableArray*)courses;

@end
