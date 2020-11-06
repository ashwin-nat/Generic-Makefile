#include "b.h"
#include <stdio.h>

void b(void)
{
    printf("This is function %s\n", __func__);
}