#include <stdlib.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <sys/errno.h>
#include <netinet/in.h>
#include <stdio.h>
#include <string.h>
#include <signal.h>
#include <netdb.h>
#include <unistd.h>

#ifndef errno
extern int errno;
#endif

int s;        		       /* socket descriptor */

struct hostent *hp;            /* pointer to info for nameserver host */
struct servent *sp;            /* pointer to service information */

struct sockaddr_in myaddr_in;  /* for local socket address */
struct sockaddr_in servaddr_in;/* for server socket addres */
char   recvbuf[1025];          /* buffer for data received from server */

#define WAITTIME 1 /* how long to wait before retrying */
#define RETRIES  5 /* # of times to retry before giving up */

void alarm_handler(int signo) { }

int
main(int argc, char* argv[])
{
  int i;
  int retry = RETRIES;          /* holds the retry count */
  char *inet_ntoa();
  sigset_t imask, omask;
  struct sigaction act, oact;


  if (argc != 4)
    {
      fprintf(stderr, "Usage:  %s <server> <service> <data_to_send>\n",
              argv[0]);
      exit(1);
    }
  /* Set up alarm signal handler. */
  sigemptyset(&imask);
  sigemptyset(&omask);
  sigaddset(&imask, SIGALRM);

  sigemptyset(&act.sa_mask);
  act.sa_handler = alarm_handler;
  act.sa_flags = 0;
  sigaction(SIGALRM, &act, &oact);


  /* clear out address structures */
  memset ((char *)&myaddr_in, 0, sizeof(struct sockaddr_in));
  memset ((char *)&servaddr_in, 0, sizeof(struct sockaddr_in));
  /* Set up the server address. */
  servaddr_in.sin_family = AF_INET;
  /* Get the host info for the server's hostname that the
   * user passed in.
   */
  hp = gethostbyname (argv[1]);
  if (hp == NULL)
    {
      fprintf(stderr, "%s: %s not found in /etc/hosts\n",
              argv[0], argv[1]);
      exit(1);
    }
  servaddr_in.sin_addr.s_addr = ((struct in_addr *)
                                 (hp->h_addr))->s_addr;
  /* Find the information for the "example" server
   * in order to get the needed port number.
   */
  sp = getservbyname (argv[2], "udp");
  if (sp == NULL)
    {
      fprintf(stderr, "%s: %s not found in /etc/services\n",
              argv[0], argv[2]);
      exit(1);
    }
  servaddr_in.sin_port = sp->s_port;

  /* Create the socket. */
  s = socket (AF_INET, SOCK_DGRAM, 0);
  if (s == -1)
    {
      perror(argv[0]);
      fprintf(stderr, "%s: unable to create socket\n", argv[0]);
      exit(1);
    }
  /* Bind socket to some local address so that the
   * server can send the reply back.  A port number
   * of zero will be used so that the system will
   * assign any available port number.  An address
   * of INADDR_ANY will be used so we do not have to
   * look up the internet address of the local host.
   */
  myaddr_in.sin_family = AF_INET;
  myaddr_in.sin_port = 0;
  myaddr_in.sin_addr.s_addr = INADDR_ANY;
  if (bind(s, (const struct sockaddr*)&myaddr_in, sizeof(struct sockaddr_in)) == -1)
    {
      perror(argv[0]);
      fprintf(stderr, "%s: unable to bind socket\n", argv[0]);
      exit(1);
    }
  /* Set up a timeout so I don't hang in case the packet
   * gets lost.  After all, UDP does not guarantee
   * delivery.
   */
  sigprocmask(SIG_SETMASK, &imask, NULL); // mask the ALRM sig while setting it
  alarm(WAITTIME);
  sigprocmask(SIG_SETMASK, &omask, NULL); // unmask now

  /* Send the request to the nameserver. */
again:
  if (sendto (s, argv[3], strlen(argv[3]), 0, (const struct sockaddr*)&servaddr_in,
              sizeof(struct sockaddr_in)) == -1)
    {
      perror(argv[0]);
      fprintf(stderr, "%s: unable to send request\n", argv[0]);
      exit(1);
    }
  /* Wait for the reply to come in.  We assume that
   * no messages will come from any other source,
   * so that we do not need to do a recvfrom nor
   * check the responder's address.
   */
  if (recv (s, &recvbuf, sizeof(recvbuf)-1, 0) == -1)
    {
      if (errno == EINTR)
        {
          /* Alarm went off & aborted the receive.
           * Need to retry the request if we have
           * not already exceeded the retry limit.
           */
          if (retry)
            {
              retry--;

              // reset alarm
              sigprocmask(SIG_SETMASK, &imask, NULL);
              alarm(WAITTIME);
              sigprocmask(SIG_SETMASK, &omask, NULL);
              goto again;
            }
          else
            {
              printf("Unable to get response from");
              printf(" %s for service %s after %d attempts.\n",
                     argv[1], argv[2], RETRIES);
              exit(1);
            }
        }
      else
        {
          perror(argv[0]);
          fprintf(stderr, "%s: unable to receive response from %s for service %s\n",
                  argv[0], argv[1], argv[2]);
          exit(1);
        }
    }

  /* mask ALRM signal, then unregister the handler */
  sigprocmask(SIG_SETMASK, &imask, NULL);
  alarm(0);
  sigaction(SIGALRM, &oact, NULL);


  /* Print out response. */
  recvbuf[sizeof(recvbuf)-1] = '\0';
  {
    int len = strlen(recvbuf);
    int i;

    if (len == 0)
      {
        printf("Received no data from %s.\n", argv[1]);
        exit(1);
      }
    else
      {
        char c;
        for (i=0; i<len; i++)
          {
            if (!isprint(recvbuf[i]))
              recvbuf[i] = '.';
          }
        printf("Received from %s: '%s'.\n", argv[1], recvbuf);
      }
  }
}

