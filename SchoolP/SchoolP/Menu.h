#import <Foundation/Foundation.h>

@class ScheduleService;
@class Lecture;
@class Admin;
@class Student;
@class Note;
@class DBService;

@interface Menu : NSObject

@property (nonatomic) int menu;

-(id) initWithMenu : (int) menu;
+(void) menu;

@end
