#include "c.h"
#include <stdio.h>

void c(void)
{
    printf("This is function %s\n", __func__);
}