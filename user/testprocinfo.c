#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"

struct procinfo {
  int pid;
  int ppid;
  int state;
  uint64 sz;
  char name[16];
};

int
main(int argc, char *argv[])
{
  struct procinfo info;
  int pid = getpid();

  if(procinfo(pid, &info) == 0){
    printf("Process: %s\n", info.name);
    printf("PID: %d, PPID: %d\n", info.pid, info.ppid);
    printf("State: %d\n", info.state);
    printf("Memory: %ld bytes\n", info.sz);
  } else {
    printf("procinfo failed\n");
  }

  exit(0);
}
