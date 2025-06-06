# Configure template for Florist
# Process this file with autoconf to produce a configure script.
# When adding new names (header-files, types, functions, etc.)
# to this file, don't forget to also add the corresponding line
# for HAVE_... to config.h.in.
define([AC_CACHE_LOAD], )dnl
define([AC_CACHE_SAVE], )dnl
AC_INIT
AC_CONFIG_SRCDIR([libsrc/posix.adb])
[echo See file "configure.log" for results of this step.]
# specifies some well-known file in the configured directory
AC_CONFIG_HEADERS([confsrc/config.h])
AC_PROG_CC

rm -f pconfig.h

AC_ARG_ENABLE(threads,
AS_HELP_STRING([--disable-threads], [Do not try to build pthread support]),,
[use_pthread=yes])
if test "x$use_pthread" = "xyes" ; then
  DEPS=deps
  SIGNALS_GENERATED=posix-implementation-ok_signals.ads
  THREADS_BOOL=True
else
  AC_MSG_WARN(No pthread support.)
  DEPS=deps_no_thread
  SIGNALS_GENERATED=
  THREADS_BOOL=False
fi
THREADS_OPTION=-XTHREADS=${THREADS_BOOL}
AC_SUBST(SIGNALS_GENERATED)
AC_SUBST(THREADS_OPTION)
AC_SUBST(DEPS)

AC_MSG_CHECKING([whether to build a shared library])
AC_ARG_ENABLE(shared,
AS_HELP_STRING([--enable-shared], [Enable build of shared libraries]),
[
AC_MSG_RESULT($enableval)
if test "$enableval" = "yes"; then
  ENABLE_SHARED="yes"
fi
],
[AC_MSG_RESULT(no)])
AC_SUBST(ENABLE_SHARED)

AC_MSG_CHECKING([build type])
AC_ARG_WITH(build-type,
AS_HELP_STRING([--with-build-type=X], [Set build type (Production/Debug)]),
[
 case "x$with_build_type" in
  xyes|xno)
     AC_MSG_ERROR(invalid build type) ;;
  *) AC_MSG_RESULT($with_build_type)
     BUILD_TYPE_OPTION="-XBuild=$with_build_type" ;;
 esac
],
[AC_MSG_RESULT(default)])
AC_SUBST(BUILD_TYPE_OPTION)

AC_MSG_CHECKING([RTS kind])
AC_ARG_WITH(rts,
AS_HELP_STRING([--with-rts=X], [Set RTS]),
[
 case "x$with_rts" in
  xyes|xno)
     AC_MSG_ERROR(invalid RTS) ;;
  *) AC_MSG_RESULT($with_rts)
     RTS_OPTION="--RTS=$with_rts" ;;
 esac
],
[AC_MSG_RESULT(default)])
AC_SUBST(RTS_OPTION)

[

# By default errno is preserved accross exceptions
safe_errno=True

echo $ac_n "checking for SGI IRIX timers... " $ac_c;
if (grep "CLOCK_SGI_FAST" /usr/include/sys/ptimers.h >/dev/null 2>&1); then
 echo "yes"
 echo "HAVE_IRIX_Timers := True" >> gnatprep.config;
else
 echo "no"
 echo "HAVE_IRIX_Timers := False" >> gnatprep.config;
fi;

UNAME_MACHINE=`(uname -m) 2>/dev/null`
UNAME_RELEASE=`(uname -r) 2>/dev/null`
UNAME_SYSTEM=`(uname -s) 2>/dev/null`
UNAME_VERSION=`(uname -v) 2>/dev/null`

echo ${UNAME_SYSTEM} ${UNAME_MACHINE} ${UNAME_RELEASE} ${UNAME_VERSION}
echo "Using Configuration for" ${UNAME_SYSTEM} ${UNAME_RELEASE};
cp ./configs/pconfig.Linux ./pconfig.h.in;

if test "x$safe_errno" = "xTrue" ; then
  safe_errno_msg="safe"
else
  safe_errno_msg="not safe"
fi
echo "We will assume errno is $safe_errno_msg for exception propagation."
echo "to override, hand-edit gnatprep.config"
echo "HAVE_Safe_Errno := $safe_errno" >> gnatprep.config;

]
# defines HAVE_NAME_H for each header "name.h" found
# also checks for location of Pthread library
# note that the order is rather touchy
# for Solaris 2.5.1, utsname.h must precede limits.h
# for Solaris 2.5.1, netinet/in.h must preceded arpa/inet.h
# for Linux 2.0.x with Provenzano (MIT) threads,
#  pthread.h must follow sched.h, since
#  pthread.h redefines symbols in sched.h;
#  the effect is to detect the problem and drop pthread.h
AC_POSIX_HEADERS(\
 aio.h\
 dirent.h\
 errno.h\
 fcntl.h\
 grp.h\
 locale.h\
 mqueue.h\
 pwd.h\
 sched.h\
 pthread.h\
 semaphore.h\
 setjmp.h\
 signal.h\
 stdio.h\
 sys/mman.h\
 sys/stat.h\
 sys/times.h\
 sys/types.h\
 sys/utsname.h\
 limits.h\
 sys/wait.h\
 termios.h\
 time.h\
 sys/time.h\
 unistd.h\
 utime.h\
)

# POSIX.5c headers are separated, because we want to do
# some special processing to try to substitute for missing standard
# header files.
# Checks for xti.h and tli.h are built-in, as is check for whether we
# need addrinfo.h.
# We always call this after AC_POSIX_HEADERS, so that pconfig.h will
# already have the other required POSIX headers in it, and in particular
# will have any lines inherited from pconfig.h.in.
AC_POSIX5C_HEADERS(
 netdb.h\
 netinet/in.h\
 netinet/in_systm.h\
 netinet/ip.h\
 netinet/tcp.h\
 arpa/inet.h\
 poll.h\
 sys/select.h\
 sys/socket.h\
 sys/uio.h\
 sys/un.h\
)

if test "x$use_pthread" = "xyes" ; then
  AC_CHECK_LIB(pthread, pthread_self,,
  [AC_CHECK_LIB(pthread, __pthread_self,,
  [AC_CHECK_LIB(pthreads, pthread_self,,
  [AC_CHECK_LIB(cma, pthread_self,,
  [AC_CHECK_LIB(:libcma.a, pthread_self,,
  [AC_CHECK_LIB(thread, pthread_self,,
  [AC_CHECK_LIB(c_r, pthread_self)])])])])])])
fi


AC_SEARCH_LIBS(aio_read, aio)
AC_SEARCH_LIBS(shm_open, rt)
AC_SEARCH_LIBS(clock_gettime, [posix4 rt])
AC_SEARCH_LIBS(gethostbyname, nsl)
AC_SEARCH_LIBS(t_bind, [nsl nsl_s])
AC_SEARCH_LIBS(accept, socket)
AC_SEARCH_LIBS(h_errno, resolv)

echo "Using LIBS=${LIBS}"
AC_SUBST(LIBS)

AC_POSIX_VAR(t_errno)
AC_POSIX_VAR(t_nerr)
AC_POSIX_COMP(msghdr, msg_control)
AC_POSIX_COMP(msghdr, msg_controllen)
AC_POSIX_COMP(msghdr, msg_flags)
AC_POSIX_COMP(sigevent, sigev_notify_function)
AC_POSIX_COMP_OVERLAY(sigaction, sa_sigaction, sa_handler)
AC_POSIX_STRUCTS(\
 addrinfo\
 aiocb\
 cmsghdr\
 dirent\
 flock\
 group\
 hostent\
 iovec\
 in_addr\
 ip_opts\
 linger\
 msghdr\
 mq_attr\
 netbuf\
 netent\
 passwd\
 pollfd\
 protoent\
 tm\
 tms\
 sched_param\
 servent\
 sigaction\
 cma_sigaction\
 sigevent\
 sockaddr\
 sockaddr_in\
 sockaddr_un\
 stat\
 termios\
 timespec\
 timeval\
 t_bind\
 t_call\
 t_discon\
 t_info\
 t_iovec\
 t_kpalive\
 t_linger\
 t_opthdr\
 t_optmgmt\
 t_uderr\
 t_unitdata\
 itimerspec\
 utimbuf\
 utsname\
)
AC_POSIX_TYPES(\
 blkcnt_t\
 blksize_t\
 cc_t\
 clockid_t\
 clock_t\
 dev_t\
 fd_set\
 ino_t\
 in_addr_t\
 in_port_t\
 mqd_t\
 nlink_t\
 pthread_attr_t\
 pthread_condattr_t\
 pthread_cond_t\
 pthread_key_t\
 pthread_mutexattr_t\
 pthread_mutex_t\
 pthread_once_t\
 pthread_t\
 sa_family_t\
 sem_t\
 siginfo_t\
 sigset_t\
 sigval\
 socklen_t\
 speed_t\
 suseconds_t\
 tcflag_t\
 timer_t\
)


AC_POSIX_FUNCS(\
 accept\
 access\
 aio_cancel\
 aio_error\
 aio_fsync\
 aio_read\
 aio_return\
 aio_suspend\
 aio_write\
 bind\
 cfgetispeed\
 cfgetospeed\
 cfsetispeed\
 cfsetospeed\
 chdir\
 chmod\
 chown\
 clock_getres\
 clock_gettime\
 clock_settime\
 close\
 closedir\
 connect\
 ctermid\
 ctime\
 ctime_r\
 dup\
 dup2\
 endhostent\
 endnetent\
 endprotoent\
 endservent\
 execl\
 execle\
 execlp\
 execv\
 execve\
 execvp\
 fchmod\
 fcntl\
 fdatasync\
 fork\
 fpathconf\
 fstat\
 fsync\
 ftruncate\
 getaddrinfo\
 getcwd\
 getegid\
 getenv\
 geteuid\
 getgid\
 getgrgid\
 getgrgid_r\
 getgrnam\
 getgrnam_r\
 getgroups\
 gethostbyaddr\
 gethostbyaddr_r\
 gethostbyname\
 gethostbyname_r\
 gethostname\
 getlogin\
 getlogin_r\
 getpeername\
 getpgrp\
 getpid\
 getppid\
 getnetbyaddr\
 getnetbyaddr_r\
 getnetbyname\
 getnetbyname_r\
 getprotobyname\
 getprotobyname_r\
 getprotobynumber\
 getprotobynumber_r\
 getservbyname\
 getservbyname_r\
 getpwnam\
 getpwnam_r\
 getpwuid\
 getpwuid_r\
 getservbyport\
 getservbyport_r\
 getsockname\
 getsockname_r\
 getsockopt\
 gettimeofday\
 getuid\
 gmtime_r\
 inet_addr\
 inet_lnaof\
 inet_makeaddr\
 inet_network\
 inet_ntoa\
 inet_netof\
 isatty\
 isfdtype\
 kill\
 link\
 lio_listio\
 listen\
 lseek\
 lstat\
 mkdir\
 mkfifo\
 mlock\
 mlockall\
 mmap\
 mprotect\
 mq_close\
 mq_getattr\
 mq_notify\
 mq_open\
 mq_receive\
 mq_send\
 mq_setattr\
 mq_unlink\
 msync\
 munlock\
 munlockall\
 munmap\
 open\
 opendir\
 pathconf\
 pipe\
 poll\
 pthread_condattr_destroy\
 pthread_condattr_getpshared\
 pthread_condattr_init\
 pthread_condattr_setpshared\
 pthread_cond_broadcast\
 pthread_cond_destroy\
 pthread_cond_init\
 pthread_cond_signal\
 pthread_cond_timedwait\
 pthread_cond_wait\
 pthread_mutexattr_destroy\
 pthread_mutexattr_getprioceiling\
 pthread_mutexattr_getprotocol\
 pthread_mutexattr_getpshared\
 pthread_mutexattr_init\
 pthread_mutexattr_setprioceiling\
 pthread_mutexattr_setprotocol\
 pthread_mutexattr_setpshared\
 pthread_mutex_destroy\
 pthread_mutex_getprioceiling\
 pthread_mutex_init\
 pthread_mutex_lock\
 pthread_mutex_setprioceiling\
 pthread_mutex_trylock\
 pthread_mutex_unlock\
 pthread_sigmask\
 putenv\
 rcvmsg\
 read\
 readdir\
 readdir_r\
 recv\
 recvfrom\
 recvmsg\
 rename\
 rand_r\
 rmdir\
 sched_getparam\
 sched_getscheduler\
 sched_get_priority_max\
 sched_get_priority_min\
 sched_rr_get_interval\
 sched_setparam\
 sched_setscheduler\
 sched_yield\
 select\
 sem_close\
 sem_destroy\
 sem_getvalue\
 sem_init\
 sem_open\
 sem_post\
 sem_trywait\
 sem_unlink\
 sem_wait\
 send\
 sendto\
 sendmsg\
 setgid\
 setenv\
 sethostent\
 setnetent\
 setpgid\
 setprotoent\
 setservent\
 setsid\
 setsockopt\
 setuid\
 shm_open\
 shm_unlink\
 shutdown\
 sigaction\
 sigaddset\
 sigdelset\
 sigemptyset\
 sigfillset\
 sigismember\
 siglongjmp\
 sigpending\
 sigprocmask\
 sigqueue\
 sigsetjmp\
 sigsuspend\
 sigtimedwait\
 sigwait\
 sigwaitinfo\
 socket\
 sockatmark\
 socketpair\
 stat\
 strtok_r\
 sysconf\
 tcdrain\
 tcflow\
 tcflush\
 tcgetattr\
 tcgetpgrp\
 tcsendbreak\
 tcsetattr\
 tcsetpgrp\
 time\
 timer_create\
 timer_delete\
 timer_getoverrun\
 timer_gettime\
 timer_settime\
 times\
 ttyname\
 ttyname_r\
 t_accept\
 t_alloc\
 t_bind\
 t_blocking\
 t_close\
 t_connect\
 t_error\
 t_free\
 t_getinfo\
 t_getprotaddr\
 t_getstate\
 t_listen\
 t_look\
 t_nonblocking\
 t_open\
 t_optmgmt\
 t_rcv\
 t_rcvconnect\
 t_rcvdis\
 t_rcvrel\
 t_rcvudata\
 t_snd\
 t_snddis\
 t_sndudata\
 t_strerror\
 t_sync\
 t_unbind\
 t_rcvreldata\
 t_rcvuderr\
 t_rcvv\
 t_rcvvudata\
 t_sndreldata\
 t_sndrel\
 t_sndv\
 t_sndvudata\
 strerror\
 strerror_r\
 perror\
 umask\
 uname\
 unlink\
 unsetenv\
 utime\
 waitpid\
 write\
 __posix_sigwait\
 __posix_ctime_r\
 __posix_readdir_r\
 __posix_sigwait_r\
 __posix_ttyname_r\
)

AC_CONFIG_FILES([Makefile])
AC_CONFIG_COMMANDS([default],[test -z "$CONFIG_HEADERS" || date > stamp-h],[])
AC_OUTPUT
