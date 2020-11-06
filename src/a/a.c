#include "a.h"
#include <stdio.h>

void a(void)
{
    printf("This is function %s\n", __func__);
}