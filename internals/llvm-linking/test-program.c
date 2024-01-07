#include <stdio.h>
#include <sys/socket.h>
#include <errno.h>
#include <arpa/inet.h>
#include <string.h>
#include <unistd.h>

#define PORT 8080
#define BUFFER_SIZE 1024

int main(int argc, char *argv[])
{
  char buffer[BUFFER_SIZE];
  char response[] = "HTTP/1.0 200 OK\r\n"
                    "Server: webserver-c\r\n"
                    "Content-type: text/html\r\n\r\n"
                    "<html>Hi Lam! </html>\r\n";

  int socketfd = socket(AF_INET, SOCK_STREAM, 0);
  if (socketfd == -1){
    perror("webserver (socketfd)");
    return 1;
  }
  printf("socket created successfully\n");   


  struct sockaddr_in host_address;
  int host_addressLength = sizeof(host_address);

  host_address.sin_family = AF_INET;
  host_address.sin_port = htons(PORT);
  host_address.sin_addr.s_addr = htonl(INADDR_ANY);

  struct sockaddr_in client_address;
  int client_addressLength = sizeof(client_address);


  if (bind(socketfd, (struct sockaddr *)&host_address, &host_addressLength) != 0){
    perror("webserver (bind)");
    return 1;
  }
  printf("socket bound to address successfully \n");
  return 0;

  if (listen(socketfd, SOMAXCONN) != 0) {
    perror("webserver (listen)");
    return 1;
  }
  printf("server listening for connections\n");
  

  for (;;) {
    int newSocketfd = accept (newSocketfd, (struct sockaddr *)&host_address,
                                    (socklen_t *)&host_addressLength);
    
    if (newSocketfd < 0) {
      perror("webserver (accept)");
      continue;
    }
    printf("connection accepted !\n");
  
    int clientSocket = getsockname(newSocketfd, (struct sockaddr *  )&client_address, 
                                                (socklen_t *)&client_addressLength);
    if (clientSocket < 0){
      perror("webserver (getsockname)");
      continue;
    }


    int value_read = read(newSocketfd, buffer, BUFFER_SIZE);
    if (value_read < 0 ){
      perror("webserver (read)");
      continue;
    }


    char method[BUFFER_SIZE], uri[BUFFER_SIZE], version[BUFFER_SIZE];
    sscanf(buffer, "%s %s %s", method, uri, version);
    printf("[%s:%u]\n", inet_ntoa(client_address.sin_addr), ntohs(client_address.sin_port));
    

    int value_write = write(newSocketfd, response, strlen(response));
    if (value_write < 0){
      perror("webserver (write)");
      continue;
    }
    close(newSocketfd);
  }
  return 0;
}
