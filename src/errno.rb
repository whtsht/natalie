class SystemCallError < StandardError
  
  def initialize(desc=nil, errno=nil)
    @desc = desc
    @errno = errno
    super()
  end
  
  def self.exception(*args)
    if args.size == 2
      detail = args.first
      num = args.last
    elsif args.size == 1
      detail = nil
      num = args.first
    else
      # TODO: Ruby accepts 3 args??
      raise ArgumentError, "wrong number of arguments (given #{args.size}, expected 1..2)"
    end

    klass_name, message = ERRORS.detect { |_, (n, _)| n == num }

    if klass_name
      message = "#{message} - #{detail}" if detail
      Errno.const_get(klass_name).new(message)
    else
      new("Unknown error #{num}")
    end
  end

  def errno
    @errno || self::Errno
  end
  
  def self.===(other)
    if !other.is_a?(SystemCallError)
      return false unless other.respond_to?(:errno)
    elsif (self == SystemCallError)
      return true
    end
    self::Errno == other.errno
  end

  # generated by [natalie-errno-gen](https://github.com/natalie-lang/natalie-errno-gen)
  if RUBY_PLATFORM =~ /openbsd/
    ERRORS = {
      EPERM: [1, "Operation not permitted"],
      ENOENT: [2, "No such file or directory"],
      ESRCH: [3, "No such process"],
      EINTR: [4, "Interrupted system call"],
      EIO: [5, "Input/output error"],
      ENXIO: [6, "Device not configured"],
      E2BIG: [7, "Argument list too long"],
      ENOEXEC: [8, "Exec format error"],
      EBADF: [9, "Bad file descriptor"],
      ECHILD: [10, "No child processes"],
      EDEADLK: [11, "Resource deadlock avoided"],
      ENOMEM: [12, "Cannot allocate memory"],
      EACCES: [13, "Permission denied"],
      EFAULT: [14, "Bad address"],
      ENOTBLK: [15, "Block device required"],
      EBUSY: [16, "Device busy"],
      EEXIST: [17, "File exists"],
      EXDEV: [18, "Cross-device link"],
      ENODEV: [19, "Operation not supported by device"],
      ENOTDIR: [20, "Not a directory"],
      EISDIR: [21, "Is a directory"],
      EINVAL: [22, "Invalid argument"],
      ENFILE: [23, "Too many open files in system"],
      EMFILE: [24, "Too many open files"],
      ENOTTY: [25, "Inappropriate ioctl for device"],
      ETXTBSY: [26, "Text file busy"],
      EFBIG: [27, "File too large"],
      ENOSPC: [28, "No space left on device"],
      ESPIPE: [29, "Illegal seek"],
      EROFS: [30, "Read-only file system"],
      EMLINK: [31, "Too many links"],
      EPIPE: [32, "Broken pipe"],
      EDOM: [33, "Numerical argument out of domain"],
      ERANGE: [34, "Result too large"],
      EAGAIN: [35, "Resource temporarily unavailable"],
      EWOULDBLOCK: [35, "Resource temporarily unavailable"],
      EINPROGRESS: [36, "Operation now in progress"],
      EALREADY: [37, "Operation already in progress"],
      ENOTSOCK: [38, "Socket operation on non-socket"],
      EDESTADDRREQ: [39, "Destination address required"],
      EMSGSIZE: [40, "Message too long"],
      EPROTOTYPE: [41, "Protocol wrong type for socket"],
      ENOPROTOOPT: [42, "Protocol not available"],
      EPROTONOSUPPORT: [43, "Protocol not supported"],
      ESOCKTNOSUPPORT: [44, "Socket type not supported"],
      EOPNOTSUPP: [45, "Operation not supported"],
      EPFNOSUPPORT: [46, "Protocol family not supported"],
      EAFNOSUPPORT: [47, "Address family not supported by protocol family"],
      EADDRINUSE: [48, "Address already in use"],
      EADDRNOTAVAIL: [49, "Can't assign requested address"],
      ENETDOWN: [50, "Network is down"],
      ENETUNREACH: [51, "Network is unreachable"],
      ENETRESET: [52, "Network dropped connection on reset"],
      ECONNABORTED: [53, "Software caused connection abort"],
      ECONNRESET: [54, "Connection reset by peer"],
      ENOBUFS: [55, "No buffer space available"],
      EISCONN: [56, "Socket is already connected"],
      ENOTCONN: [57, "Socket is not connected"],
      ESHUTDOWN: [58, "Can't send after socket shutdown"],
      ETOOMANYREFS: [59, "Too many references: can't splice"],
      ETIMEDOUT: [60, "Operation timed out"],
      ECONNREFUSED: [61, "Connection refused"],
      ELOOP: [62, "Too many levels of symbolic links"],
      ENAMETOOLONG: [63, "File name too long"],
      EHOSTDOWN: [64, "Host is down"],
      EHOSTUNREACH: [65, "No route to host"],
      ENOTEMPTY: [66, "Directory not empty"],
      EPROCLIM: [67, "Too many processes"],
      EUSERS: [68, "Too many users"],
      EDQUOT: [69, "Disk quota exceeded"],
      ESTALE: [70, "Stale NFS file handle"],
      EREMOTE: [71, "Too many levels of remote in path"],
      EBADRPC: [72, "RPC struct is bad"],
      ERPCMISMATCH: [73, "RPC version wrong"],
      EPROGUNAVAIL: [74, "RPC program not available"],
      EPROGMISMATCH: [75, "Program version wrong"],
      EPROCUNAVAIL: [76, "Bad procedure for program"],
      ENOLCK: [77, "No locks available"],
      ENOSYS: [78, "Function not implemented"],
      EFTYPE: [79, "Inappropriate file type or format"],
      EAUTH: [80, "Authentication error"],
      ENEEDAUTH: [81, "Need authenticator"],
      EIPSEC: [82, "IPsec processing failure"],
      ENOATTR: [83, "Attribute not found"],
      EILSEQ: [84, "Illegal byte sequence"],
      ENOMEDIUM: [85, "No medium found"],
      EMEDIUMTYPE: [86, "Wrong medium type"],
      EOVERFLOW: [87, "Value too large to be stored in data type"],
      ECANCELED: [88, "Operation canceled"],
      EIDRM: [89, "Identifier removed"],
      ENOMSG: [90, "No message of desired type"],
      ENOTSUP: [91, "Not supported"],
      EBADMSG: [92, "Bad message"],
      ENOTRECOVERABLE: [93, "State not recoverable"],
      EOWNERDEAD: [94, "Previous owner died"],
      EPROTO: [95, "Protocol error"],
      ELAST: [95, "Protocol error"],
    }
  elsif RUBY_PLATFORM =~ /darwin/
    ERRORS = {
      EPERM: [1, "Operation not permitted"],
      ENOENT: [2, "No such file or directory"],
      ESRCH: [3, "No such process"],
      EINTR: [4, "Interrupted system call"],
      EIO: [5, "Input/output error"],
      ENXIO: [6, "Device not configured"],
      E2BIG: [7, "Argument list too long"],
      ENOEXEC: [8, "Exec format error"],
      EBADF: [9, "Bad file descriptor"],
      ECHILD: [10, "No child processes"],
      EDEADLK: [11, "Resource deadlock avoided"],
      ENOMEM: [12, "Cannot allocate memory"],
      EACCES: [13, "Permission denied"],
      EFAULT: [14, "Bad address"],
      ENOTBLK: [15, "Block device required"],
      EBUSY: [16, "Resource busy"],
      EEXIST: [17, "File exists"],
      EXDEV: [18, "Cross-device link"],
      ENODEV: [19, "Operation not supported by device"],
      ENOTDIR: [20, "Not a directory"],
      EISDIR: [21, "Is a directory"],
      EINVAL: [22, "Invalid argument"],
      ENFILE: [23, "Too many open files in system"],
      EMFILE: [24, "Too many open files"],
      ENOTTY: [25, "Inappropriate ioctl for device"],
      ETXTBSY: [26, "Text file busy"],
      EFBIG: [27, "File too large"],
      ENOSPC: [28, "No space left on device"],
      ESPIPE: [29, "Illegal seek"],
      EROFS: [30, "Read-only file system"],
      EMLINK: [31, "Too many links"],
      EPIPE: [32, "Broken pipe"],
      EDOM: [33, "Numerical argument out of domain"],
      ERANGE: [34, "Result too large"],
      EAGAIN: [35, "Resource temporarily unavailable"],
      EWOULDBLOCK: [35, "Resource temporarily unavailable"],
      EINPROGRESS: [36, "Operation now in progress"],
      EALREADY: [37, "Operation already in progress"],
      ENOTSOCK: [38, "Socket operation on non-socket"],
      EDESTADDRREQ: [39, "Destination address required"],
      EMSGSIZE: [40, "Message too long"],
      EPROTOTYPE: [41, "Protocol wrong type for socket"],
      ENOPROTOOPT: [42, "Protocol not available"],
      EPROTONOSUPPORT: [43, "Protocol not supported"],
      ESOCKTNOSUPPORT: [44, "Socket type not supported"],
      ENOTSUP: [45, "Operation not supported"],
      EPFNOSUPPORT: [46, "Protocol family not supported"],
      EAFNOSUPPORT: [47, "Address family not supported by protocol family"],
      EADDRINUSE: [48, "Address already in use"],
      EADDRNOTAVAIL: [49, "Can't assign requested address"],
      ENETDOWN: [50, "Network is down"],
      ENETUNREACH: [51, "Network is unreachable"],
      ENETRESET: [52, "Network dropped connection on reset"],
      ECONNABORTED: [53, "Software caused connection abort"],
      ECONNRESET: [54, "Connection reset by peer"],
      ENOBUFS: [55, "No buffer space available"],
      EISCONN: [56, "Socket is already connected"],
      ENOTCONN: [57, "Socket is not connected"],
      ESHUTDOWN: [58, "Can't send after socket shutdown"],
      ETOOMANYREFS: [59, "Too many references: can't splice"],
      ETIMEDOUT: [60, "Operation timed out"],
      ECONNREFUSED: [61, "Connection refused"],
      ELOOP: [62, "Too many levels of symbolic links"],
      ENAMETOOLONG: [63, "File name too long"],
      EHOSTDOWN: [64, "Host is down"],
      EHOSTUNREACH: [65, "No route to host"],
      ENOTEMPTY: [66, "Directory not empty"],
      EPROCLIM: [67, "Too many processes"],
      EUSERS: [68, "Too many users"],
      EDQUOT: [69, "Disc quota exceeded"],
      ESTALE: [70, "Stale NFS file handle"],
      EREMOTE: [71, "Too many levels of remote in path"],
      EBADRPC: [72, "RPC struct is bad"],
      ERPCMISMATCH: [73, "RPC version wrong"],
      EPROGUNAVAIL: [74, "RPC prog. not avail"],
      EPROGMISMATCH: [75, "Program version wrong"],
      EPROCUNAVAIL: [76, "Bad procedure for program"],
      ENOLCK: [77, "No locks available"],
      ENOSYS: [78, "Function not implemented"],
      EFTYPE: [79, "Inappropriate file type or format"],
      EAUTH: [80, "Authentication error"],
      ENEEDAUTH: [81, "Need authenticator"],
      EPWROFF: [82, "Device power is off"],
      EDEVERR: [83, "Device error"],
      EOVERFLOW: [84, "Value too large to be stored in data type"],
      EBADEXEC: [85, "Bad executable (or shared library)"],
      EBADARCH: [86, "Bad CPU type in executable"],
      ESHLIBVERS: [87, "Shared library version mismatch"],
      EBADMACHO: [88, "Malformed Mach-o file"],
      ECANCELED: [89, "Operation canceled"],
      EIDRM: [90, "Identifier removed"],
      ENOMSG: [91, "No message of desired type"],
      EILSEQ: [92, "Illegal byte sequence"],
      ENOATTR: [93, "Attribute not found"],
      EBADMSG: [94, "Bad message"],
      EMULTIHOP: [95, "EMULTIHOP (Reserved)"],
      ENODATA: [96, "No message available on STREAM"],
      ENOLINK: [97, "ENOLINK (Reserved)"],
      ENOSR: [98, "No STREAM resources"],
      ENOSTR: [99, "Not a STREAM"],
      EPROTO: [100, "Protocol error"],
      ETIME: [101, "STREAM ioctl timeout"],
      EOPNOTSUPP: [102, "Operation not supported on socket"],
      ENOPOLICY: [103, "Policy not found"],
      ENOTRECOVERABLE: [104, "State not recoverable"],
      EOWNERDEAD: [105, "Previous owner died"],
      EQFULL: [106, "Interface output queue is full"],
      ELAST: [106, "Interface output queue is full"],
    }
  else
    ERRORS = {
      EPERM: [1, "Operation not permitted"],
      ENOENT: [2, "No such file or directory"],
      ESRCH: [3, "No such process"],
      EINTR: [4, "Interrupted system call"],
      EIO: [5, "Input/output error"],
      ENXIO: [6, "No such device or address"],
      E2BIG: [7, "Argument list too long"],
      ENOEXEC: [8, "Exec format error"],
      EBADF: [9, "Bad file descriptor"],
      ECHILD: [10, "No child processes"],
      EAGAIN: [11, "Resource temporarily unavailable"],
      ENOMEM: [12, "Cannot allocate memory"],
      EACCES: [13, "Permission denied"],
      EFAULT: [14, "Bad address"],
      ENOTBLK: [15, "Block device required"],
      EBUSY: [16, "Device or resource busy"],
      EEXIST: [17, "File exists"],
      EXDEV: [18, "Invalid cross-device link"],
      ENODEV: [19, "No such device"],
      ENOTDIR: [20, "Not a directory"],
      EISDIR: [21, "Is a directory"],
      EINVAL: [22, "Invalid argument"],
      ENFILE: [23, "Too many open files in system"],
      EMFILE: [24, "Too many open files"],
      ENOTTY: [25, "Inappropriate ioctl for device"],
      ETXTBSY: [26, "Text file busy"],
      EFBIG: [27, "File too large"],
      ENOSPC: [28, "No space left on device"],
      ESPIPE: [29, "Illegal seek"],
      EROFS: [30, "Read-only file system"],
      EMLINK: [31, "Too many links"],
      EPIPE: [32, "Broken pipe"],
      EDOM: [33, "Numerical argument out of domain"],
      ERANGE: [34, "Numerical result out of range"],
      EDEADLK: [35, "Resource deadlock avoided"],
      ENAMETOOLONG: [36, "File name too long"],
      ENOLCK: [37, "No locks available"],
      ENOSYS: [38, "Function not implemented"],
      ENOTEMPTY: [39, "Directory not empty"],
      ELOOP: [40, "Too many levels of symbolic links"],
      EWOULDBLOCK: [11, "Resource temporarily unavailable"],
      ENOMSG: [42, "No message of desired type"],
      EIDRM: [43, "Identifier removed"],
      ECHRNG: [44, "Channel number out of range"],
      EL2NSYNC: [45, "Level 2 not synchronized"],
      EL3HLT: [46, "Level 3 halted"],
      EL3RST: [47, "Level 3 reset"],
      ELNRNG: [48, "Link number out of range"],
      EUNATCH: [49, "Protocol driver not attached"],
      ENOCSI: [50, "No CSI structure available"],
      EL2HLT: [51, "Level 2 halted"],
      EBADE: [52, "Invalid exchange"],
      EBADR: [53, "Invalid request descriptor"],
      EXFULL: [54, "Exchange full"],
      ENOANO: [55, "No anode"],
      EBADRQC: [56, "Invalid request code"],
      EBADSLT: [57, "Invalid slot"],
      EDEADLOCK: [35, "Resource deadlock avoided"],
      EBFONT: [59, "Bad font file format"],
      ENOSTR: [60, "Device not a stream"],
      ENODATA: [61, "No data available"],
      ETIME: [62, "Timer expired"],
      ENOSR: [63, "Out of streams resources"],
      ENONET: [64, "Machine is not on the network"],
      ENOPKG: [65, "Package not installed"],
      EREMOTE: [66, "Object is remote"],
      ENOLINK: [67, "Link has been severed"],
      EADV: [68, "Advertise error"],
      ESRMNT: [69, "Srmount error"],
      ECOMM: [70, "Communication error on send"],
      EPROTO: [71, "Protocol error"],
      EMULTIHOP: [72, "Multihop attempted"],
      EDOTDOT: [73, "RFS specific error"],
      EBADMSG: [74, "Bad message"],
      EOVERFLOW: [75, "Value too large for defined data type"],
      ENOTUNIQ: [76, "Name not unique on network"],
      EBADFD: [77, "File descriptor in bad state"],
      EREMCHG: [78, "Remote address changed"],
      ELIBACC: [79, "Can not access a needed shared library"],
      ELIBBAD: [80, "Accessing a corrupted shared library"],
      ELIBSCN: [81, ".lib section in a.out corrupted"],
      ELIBMAX: [82, "Attempting to link in too many shared libraries"],
      ELIBEXEC: [83, "Cannot exec a shared library directly"],
      EILSEQ: [84, "Invalid or incomplete multibyte or wide character"],
      ERESTART: [85, "Interrupted system call should be restarted"],
      ESTRPIPE: [86, "Streams pipe error"],
      EUSERS: [87, "Too many users"],
      ENOTSOCK: [88, "Socket operation on non-socket"],
      EDESTADDRREQ: [89, "Destination address required"],
      EMSGSIZE: [90, "Message too long"],
      EPROTOTYPE: [91, "Protocol wrong type for socket"],
      ENOPROTOOPT: [92, "Protocol not available"],
      EPROTONOSUPPORT: [93, "Protocol not supported"],
      ESOCKTNOSUPPORT: [94, "Socket type not supported"],
      EOPNOTSUPP: [95, "Operation not supported"],
      EPFNOSUPPORT: [96, "Protocol family not supported"],
      EAFNOSUPPORT: [97, "Address family not supported by protocol"],
      EADDRINUSE: [98, "Address already in use"],
      EADDRNOTAVAIL: [99, "Cannot assign requested address"],
      ENETDOWN: [100, "Network is down"],
      ENETUNREACH: [101, "Network is unreachable"],
      ENETRESET: [102, "Network dropped connection on reset"],
      ECONNABORTED: [103, "Software caused connection abort"],
      ECONNRESET: [104, "Connection reset by peer"],
      ENOBUFS: [105, "No buffer space available"],
      EISCONN: [106, "Transport endpoint is already connected"],
      ENOTCONN: [107, "Transport endpoint is not connected"],
      ESHUTDOWN: [108, "Cannot send after transport endpoint shutdown"],
      ETOOMANYREFS: [109, "Too many references: cannot splice"],
      ETIMEDOUT: [110, "Connection timed out"],
      ECONNREFUSED: [111, "Connection refused"],
      EHOSTDOWN: [112, "Host is down"],
      EHOSTUNREACH: [113, "No route to host"],
      EALREADY: [114, "Operation already in progress"],
      EINPROGRESS: [115, "Operation now in progress"],
      ESTALE: [116, "Stale file handle"],
      EUCLEAN: [117, "Structure needs cleaning"],
      ENOTNAM: [118, "Not a XENIX named type file"],
      ENAVAIL: [119, "No XENIX semaphores available"],
      EISNAM: [120, "Is a named type file"],
      EREMOTEIO: [121, "Remote I/O error"],
      EDQUOT: [122, "Disk quota exceeded"],
      ENOMEDIUM: [123, "No medium found"],
      EMEDIUMTYPE: [124, "Wrong medium type"],
      ECANCELED: [125, "Operation canceled"],
      ENOKEY: [126, "Required key not available"],
      EKEYEXPIRED: [127, "Key has expired"],
      EKEYREVOKED: [128, "Key has been revoked"],
      EKEYREJECTED: [129, "Key was rejected by service"],
      EOWNERDEAD: [130, "Owner died"],
      ENOTRECOVERABLE: [131, "State not recoverable"],
      ERFKILL: [132, "Operation not possible due to RF-kill"],
      EHWPOISON: [133, "Memory page has hardware error"],
      ENOTSUP: [95, "Operation not supported"],
    }
  end
end

module Errno
end

SystemCallError::ERRORS.each do |name, (number, _desc)|
  klass = Class.new(SystemCallError)
  klass.const_set(:Errno, number)
  Errno.const_set(name, klass)
end
