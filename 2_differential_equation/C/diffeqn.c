#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

int main(int argc, char *argv[]) {
    char command;
    float x, y, dx, u, a = 0;
    unsigned int xFlag, yFlag, dxFlag, uFlag, aFlag;
    xFlag = yFlag = dxFlag = uFlag = aFlag = 0;

    printf ("Differential equation solver\n");
    printf ("Usage: -x <x0> -y <y0> -d <dx> -u <u0> -a <a>\n");

    while ((command = getopt(argc, argv, "hx:y:u:d:a:")) != -1) {
        switch (command) {
        case 'x':
            if (xFlag == 0) {
                xFlag = 1;
                if (sscanf(optarg, "%f", &x) != 1) {
                    printf ("Error: invalid x0\n");
                    printf ("Usage: -x <x0> -y <y0> -d <dx> -u <u0> -a <a>\n");
                    return 1;
                }
            }
            break;
        case 'y':
            if (yFlag == 0) {
                yFlag = 1;
                if (sscanf(optarg, "%f", &y) != 1) {
                    printf ("Error: invalid y0\n");
                    printf ("Usage: -x <x0> -y <y0> -d <dx> -u <u0> -a <a>\n");
                    return 1;
                }
            }
            break;
        case 'd':
            if (dxFlag == 0) {
                dxFlag = 1;
                if (sscanf(optarg, "%f", &dx) != 1) {
                    printf ("Error: invalid dx\n");
                    printf ("Usage: -x <x0> -y <y0> -d <dx> -u <u0> -a <a>\n");
                    return 1;
                }
            }
            break;
        case 'u':
            if (uFlag == 0) {
                uFlag = 1;
                if (sscanf(optarg, "%f", &u) != 1) {
                    printf ("Error: invalid u0\n");
                    printf ("Usage: -x <x0> -y <y0> -d <dx> -u <u0> -a <a>\n");
                    return 1;
                }
            }
            break;
        case 'a':
            if (aFlag == 0) {
                aFlag = 1;
                if (sscanf(optarg, "%f", &x) != 1) {
                    printf ("Error: invalid a\n");
                    printf ("Usage: -x <x0> -y <y0> -d <dx> -u <u0> -a <a>\n");
                    return 1;
                }
            }
            break;
        case 'h':
            printf ("Usage: -x <x0> -y <y0> -d <dx> -u <u0> -a <a>\n");
            return 0;
            break;
        default:
        break;
        }
    }
    
    unsigned int checkFlag = xFlag * yFlag * dxFlag * uFlag * aFlag;

    if (checkFlag != 1) {
        printf("Error: invalid arguments\n");
        printf ("Usage: -x <x0> -y <y0> -d <dx> -u <u0> -a <a>\n");
        return 1;
    }

    printf ("x: %f; y: %f; dx: %f; u: %f; a: %f\n", x, y, dx, u, a);

    int done = 1;
    float xtmp, ytmp, utmp;
    
    while (done) {
        xtmp = x + dx;
        ytmp = y + (u * dx);
        utmp = u - (3 * x * u * dx) - (3 * y * dx);
        x = xtmp;
        y = ytmp;
        u = utmp;
        done = x < a;
        printf ("x: %f     y: %f\n", x, y);
    }
    printf ("RESULTS:\nx: %f    y: %f\n", x, y);
}