//
//  main.m
//  SwiftProxy
//
//  Created by Teodor Dermendzhiev on 23.11.22.
//

#import <Foundation/Foundation.h>

void* aclass_create(int);
void* aclass_printCount(void*);
int test_getProp_int(void*, void*);

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
    }
    
    void* inst = aclass_create(5);
    aclass_printCount(inst);
    NSNumber* number = [[NSNumber alloc] initWithInt:test_getProp_int(inst, "count")];
    NSLog(@"%@", number);
    return 0;
}
