//
// Created by octo on 8/21/24.
//

#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <bits/signum-arch.h>
#include <sys/wait.h>

int main(const int argc, char* argv[]) {
    execvp(argv[1], &argv[1]);
    exit(EXIT_SUCCESS);
}