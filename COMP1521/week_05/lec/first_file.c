#include <unistd.h>
#include <stdio.h>
#include <fcntl.h>
#include <string.h>


#define FILENAME "myfile" 
#define STW "bongani"

int main(void) {
    int fd = open(FILENAME, O_WRONLY | O_CREAT | O_TRUNC, 0660);
    if (fd == 0) {
        perror("could not open the file");
        return -1;
    }
    char *buf = STW;
    ssize_t bytes_written = write(fd, buf, strlen(buf));
    if (bytes_written == -1) {
        perror("failed to write file");
        return -1;
    }
    close(fd);
    
    char inbuf[10];
    ssize_t bytes_read = read(fd, inbuf, sizeof(inbuf) - 1);
    if (bytes_written == -1) {
        perror("failed to read file");
        return -1;
    }
    return 0;
}