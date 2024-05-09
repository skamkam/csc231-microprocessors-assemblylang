#include <stdio.h>
#include <stdlib.h> //malloc
#include <string.h>

int convertCharsToInt(char char1, char char2);

int main (int argc, char *argv[]) {
    int i, len, input_ch, dsize = 0, dspace = 8;
    char **dict, fileName[100], ch1, ch2;
    FILE *filep;
    
    //FILE OPENING STUFF
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
    
    //DICT SETUP: MALLOC
    dict = (char**) malloc(sizeof(char*) * dspace); //dict entries are char* (str) type
    
    //LEMPEL ZIV
    while ( fscanf(filep, "%c%c", &ch1, &ch2) != EOF ) {
        input_ch = convertCharsToInt(ch1, ch2);
        
        if (input_ch == 0) {
            //if previous dict entry was 0: scan in new 'word'
            dict[dsize] = malloc(sizeof(char) * 2); //malloc new char & null ch
            fscanf(filep, "%c", &dict[dsize][0]); //scan in new letter to ch
            dict[dsize][1] = '\0';
            printf("%s", dict[dsize]);
            dsize++;
        }
        
        else {
            //else adds a multiple character entry to dict and print
            len = strlen(dict[input_ch-1]); //up to, not incl, null ch
            dict[dsize] = malloc(sizeof(char)*(len+2)); //old chars, new char & null ch
            strcpy(dict[dsize], dict[input_ch-1]); //copy old dict entry to new
            fscanf(filep, "%c", &dict[dsize][len]); // save next char to dict
            dict[dsize][len+1] = '\0';
            printf("%s", dict[dsize]); //print new dict entry to output
            dsize++;
        }
        
        if (dsize == dspace) { //dict full
            dspace = 2 * dspace;
            dict = (char**) realloc(dict, sizeof(char*)*dspace);
        }
    }
    
    for (i = 0; i < dspace; i++) {
        free(dict[i]);
    }
    free(dict);
    fclose(filep);

    return 0;
}


int convertCharsToInt(char char1, char char2) {
    return ((unsigned char) char1)
    + ( ((unsigned char) char2) << 8);
}