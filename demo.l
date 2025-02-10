%{
#include <stdio.h>
#include <string.h>

void check_validity(char *yytext);
int yywrap(void);  // Proper function prototype

%}

%%

[0-9]+    { check_validity(yytext); }

%%

void check_validity(char *yytext) {
    int count[10] = {0}; // Count array for digits 0-9
    int repeated = 0;
    
    for (int i = 0; yytext[i] != '\0'; i++) {
        count[yytext[i] - '0']++;
        if (count[yytext[i] - '0'] == 2) {
            repeated++;
        }
    }

    if (repeated > 1) {
        printf("Invalid string: %s (More than one repeated digit)\n", yytext);
    } else {
        printf("Valid string: %s\n", yytext);
    }
}

// Proper yywrap() definition
int yywrap(void) {
    return 1;
}

int main() {
    printf("Enter strings of digits (Press Ctrl+D to exit):\n");
    yylex();
    return 0;
}
