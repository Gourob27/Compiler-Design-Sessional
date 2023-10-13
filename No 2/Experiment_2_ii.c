/*Write a program For validating operators.*/
#include <stdio.h>
#include <string.h>
#include <ctype.h>

int main()
{
    char str[20];
    int i, flag = 0;
    printf("Enter the operator: ");
    scanf("%s", str);
    if (strlen(str) == 1)
    {
        if (
        str[0] == '+' || str[0] == '-' || str[0] == '*' || str[0] == '/' || 
        str[0] == '%' || str[0] == '=' || str[0] == '&' || str[0] == '^' || 
        str[0] == '|' || str[0] == '>' || str[0] == '<' || str[0] == '!')
        {
            flag = 1;
        }
    }

    else if (strlen(str) == 2)
    {
        if ((str[0] == '+' && str[1] == '+') || (str[0] == '-' && str[1] == '-'))
        {
            flag = 1;
        }
        if ((str[0] == '&' && str[1] == '&') || (str[0] == '|' && str[1] == '|'))
        {
            flag = 1;
        }
        if (str[0] == '+' || str[0] == '-' || str[0] == '*' || str[0] == '/' || str[0] == '%' || str[0] == '=' || str[0] == '&' || str[0] == '^' || str[0] == '|' || str[0] == '>' || str[0] == '<' || str[0] == '!')
        {
            if (str[1] == '=')
            {
                flag = 1;
            }
        }
    }
    else if (strlen(str) == 3)
    {
        if ((str[0] == '>' && str[1] == '>' && str[2] == '=') || (str[0] == '<' && str[1] == '<' && str[2] == '='))
        {
            flag = 1;
        }
    }

    if (flag == 1)
    {
        printf("Valid Operator");
    }
    else
    {
        printf("Invalid Operator");
    }
    return 0;
}