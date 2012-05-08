#import <Foundation/Foundation.h>

@interface Admin : NSObject

@property (nonatomic, copy) NSString *firstName;
@property (nonatomic, copy) NSString *lastName;
@property (nonatomic, copy) NSString *mailAddress;

-(id) initWithAdminName: (NSString *)name lastName: (NSString *) lastName MailAddress: (NSString *)mailAddress;

+(id) adminWithName: (NSString *)name lastName: (NSString *) lastName MailAddress: (NSString *)mailAddress;

-(void) sendMessageToStudentWithMailAdress: (NSString *)mail;

-(void) sendMessageToStudents: (NSString *)mail;

-(void) addNewScheduleForCourse: (NSString *)course teacherName: (NSString *) name day:(NSString *) day time: (NSNumber *)time;

-(void) editSchedule: (NSString *)schedule day:(NSString *) day time: (NSNumber *) time;


@end
