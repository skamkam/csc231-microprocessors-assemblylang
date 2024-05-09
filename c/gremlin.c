//skeleton code provided by Prof. Jamie Macbeth, CSC231, Smith College

#include <stdio.h>
#include <string.h>

int main( int argc, char *argv[] ) {
    char fileName[100];
    int ch;
    FILE *filep;
    
    // display syntax if no arguments passed on command line
    if ( argc <= 1 ) {
        printf("Syntax: %s filename\n", argv[0] );
        return 1;
    }

    // if an argument is passed, it must be a file name
    strcpy( fileName, argv[1] );
    
    filep = fopen(fileName, "r");
    
    if (filep == NULL) {
        printf("Error: unable to open file\n");
        exit(1);
    }
    
    ch = getc(filep);
    while (ch != EOF) {
        if (ch == 'g') {        printf("gremlin");      }
        else if (ch == 'G') {       printf("GREMLIN");      }
        else {      printf("%c", ch);     }
        ch = getc(filep);
    }
    
    fclose(filep);
    
    return 0;
}
