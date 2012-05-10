#import <Foundation/Foundation.h>

@interface Admin : NSObject

@property (nonatomic, copy) NSString *firstName;
@property (nonatomic, copy) NSString *lastName;
@property (nonatomic, copy) NSString *mailAddress;
@property (nonatomic, copy) NSString *phoneNumber;
//@property (nonatomic, copy) NSArray *courses;

+(id) adminWithName: (NSString *)name lastName: (NSString *) lastName mailAddress: (NSString *)mailAddress phoneNumber: (NSString *) phoneNumber courses: (NSArray *) courses;

-(id) initWithAdminName: (NSString *)name lastName: (NSString *) lastName mailAddress: (NSString *)mailAddress phoneNumber: (NSString *) phoneNumber courses: (NSArray *) courses;

-(void) sendMessageToStudentWithMailAdress: (NSString *)mail;

-(void) sendMessageToStudents: (NSString *)mail;

-(void) addNewScheduleForCourse: (NSString *)course teacherName: (NSString *) name day:(NSString *) day time: (NSNumber *)time;

-(void) editSchedule: (NSString *)schedule day:(NSString *) day time: (NSNumber *) time;


@end