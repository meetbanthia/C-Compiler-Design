#include<stdio.h>

void mani(){
    // Single line comment
    
    /* Multi-line comment
       Like this */
    
    /* here */ int a; /* "int a" should be untouched */
    int b;
    a = b+a;
    printf("%d,a);
	// This nesed comment // This comment should be removed should be removed


	
	/* To make things /*  nested multi-line comment */ interesting */

	return 0;
}