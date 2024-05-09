#include <stdio.h>
#include <stdlib.h>

void gameplay(char **arr, int bsize);

char** playerturn(char **arr, int *player, int bsize);

char checkwin(char **arr, int bsize);

void printboard(char **arr, int bsize);

int main() {
    char **board, outputChoice;
    int bsize, i, j; // bsize = board size
    
    printf("Board Size (3..N):\n");
    scanf("%d", &bsize);
    if (bsize < 3) { //check bsize is valid
        printf("Inappropriate value. Goodbye.\n");
        exit(1);
    }
    
    board = malloc(sizeof(char *) * bsize); //array of bsize int pointers
    for (i = 0; i < bsize; i++) {
        board[i] = malloc(sizeof(char) * bsize); //alloc bsize arrays in each of bsize indices
    }
    for (i = 0; i < bsize; i++) { //initialize board as whitespaces
        for (j = 0; j < bsize; j++) {
            board[i][j] = ' ';
        }
    }
    
    gameplay(board, bsize);

    for (i = 0; i < bsize; i++) {
        free(board[i]);    }
    free(board);
    
    return 0;
}

void gameplay(char **arr, int bsize) {
    char gameEnd = 'n', outputChoice;
    int *player;
    
    player = malloc(sizeof(int)); //allots space for player pointer
    *player = 1; //assigns value of address equal to 1 w/ dereference

    printf("Output Play (y/n):\n");
    scanf(" %c", &outputChoice);
    if ((outputChoice != 'y') & outputChoice != 'n') {
        printf("Inappropriate value. Goodbye.\n");
        exit(1);
    }
    
    printf("You entered %d %c.\n", bsize, outputChoice);
    
    printf("Starting game with %d x %d board.\n", bsize, bsize);
    printf("Each player should enter\n");
    printf("a row and col num (eg: 2 0).\n");
    
    while (gameEnd == 'n') {
        arr = playerturn(arr, player, bsize); //passes char **arr and int *player to function
        
        if (outputChoice == 'y') {        printboard(arr, bsize);        }
        
        gameEnd = checkwin(arr, bsize);
        if (gameEnd == 'y') { //check if game ends now and current player wins
            printf("Player %d is the winner.\n", *player);
            printboard(arr, bsize);
        }
        else if (gameEnd == 't') { //game is a tie
            printf("Who wins?? Nobody!\n");
            printboard(arr, bsize);
        }
        else { // swaps to the next players turn
            if (*player == 1) {     *player = 2;        }
            else if (*player == 2) {        *player = 1;        }
        }
    }
    
    free(player);
}

char** playerturn(char **arr, int *player, int bsize) {
    int row, col, valid = 1; //default set to valid = false
    printf("Player %d:\n", *player); //dereference player
    scanf(" %d %d", &row, &col); //get player input
    
    if ( (row == -1) | (col == -1) ) {     exit(1);     }
    
    // check if bounds of entry are legal
    while ( valid == 1 ) {
        valid = 0; //set to true, will set to false later if invalid
        
        // check if within bounds & free spot
        // if not, set valid = false so while loop will check again
        if ( (row >= 0) & (row < bsize) & (col >= 0) & (col < bsize) ) {
            if (arr[row][col] != ' ') {
                valid = 1;
                printf("Incorrect value, try again.\n");
                printf("Player %d:\n", *player); //dereference player
                scanf("%d %d", &row, &col); //get new player input
            }
        }
        
        // check if outside bounds
        // if not, set valid = false so while loop will check again
        if ( (row < 0) | (row >= bsize) | (col < 0) | (col >= bsize) ) {
            valid = 1;
            printf("Incorrect value, try again.\n");
            printf("Player %d:\n", *player); //dereference player
            scanf("%d %d", &row, &col); //get new player input
        }
    }

    printf("Player %d entered %d %d.\n", *player, row, col);
    
    if (*player == 1) {        arr[row][col] = 'O';       }
    else {        arr[row][col] = 'X';       }

    return arr;
} 

char checkwin(char **arr, int bsize) {
    int i, j, count;
    
    //check rows
    for (i = 0; i < bsize; i++) {
        count = 1; //set count = 1 bc we check n-1 pairs of letters
        for (j = 1; j < bsize; j++) {
            if ((arr[i][j-1] == arr[i][j]) & (arr[i][j] != ' ')) { //checks if current letter in row matches prev, not whitespace
                count++;
            } //if
        } // for j
        if (count == bsize) {         return 'y';        }
    }
    
    //check cols
    for (j = 0; j < bsize; j++) {
        count = 1;
        for (i = 1; i < bsize; i++) {
            if ((arr[i-1][j] == arr[i][j]) & (arr[i][j] != ' ')) { //checks if current letter in col matches prev
                count++;
            }//if
        } //for i
        if (count == bsize) {       return 'y';     }
    }
    
    //top left to bottom right diag
    count = 1;
    for (i = 1; i < bsize; i++) {
        if ((arr[i][i] == arr[i-1][i-1]) & (arr[i][i] != ' ')) {
            count++;
        }//if
    }
    if (count == bsize) {       return 'y';     }
    
    //top right to bottom left diag
    count = 1;
    for (i = 1; i < bsize; i++) {
        if ((arr[i-1][bsize-i] == arr[i][bsize-i-1]) & (arr[i-1][bsize-i] != ' ')) {
            count++;
        }
    }//for
    if (count == bsize) {       return 'y';     }
    
    //tie condition
    count = 0;
    for (i = 0; i < bsize; i++) {
        for (j = 0; j < bsize; j++) {
            if (arr[i][j] == ' ') {
                count++;
            }
        }
    }
    if (count == 0) {       return 't';     } //all whitespaces are taken and no one has won

    //otherwise continue game
    return 'n';
}

void printboard(char **arr, int bsize) {
    int i, j;
    char dashstr[(2+(4*bsize))]; // # dashes = 4*bsize+1; then +1 for null char
    for (i = 0; i < (1 + (4*bsize)); i++) {     dashstr[i] = '-';   }
    dashstr[1+(4*bsize)] = '\0';
    
    printf("%s\n", dashstr);
    for (i = 0; i < (2*bsize); i++) {
        // printed board size is 2*bsize+3
        // but we iterate over i=0 (i/2 = 0) to i < 2*bsize (i/2 = (bsize-1))
        if ((i % 2) == 0) { // if even line, print characters
            for (j = 0; j < bsize; j++) {
                printf("| %c ", arr[i/2][j]);
                //printf(" %d %d\n", i/2, j);
            }
            printf("|\n"); // finish line
        } // if even line
        if ((i % 2) == 1) {
            printf("%s\n", dashstr); // if odd line, print dashes
        } // if odd line
    }
}
