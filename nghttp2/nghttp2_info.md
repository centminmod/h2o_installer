Nghttp2: HTTP/2 C Library Info
=========================================
https://nghttp2.org/

nghttp2 is an implementation of HTTP/2 in C

Below is nghttp2 reference help files for nghttp2 compiled on CentOS 6.6 64bit server:

* [client = nghttp](https://github.com/centminmod/h2o_installer/blob/master/nghttp2/nghttp2_info.md#nghttp-client)
* [server = nghttpd](https://github.com/centminmod/h2o_installer/blob/master/nghttp2/nghttp2_info.md#nghttpd-server)
* [proxy = nghttpx](https://github.com/centminmod/h2o_installer/blob/master/nghttp2/nghttp2_info.md#nghttpx-proxy)
* [h2load load testing tool = h2load](https://github.com/centminmod/h2o_installer/blob/master/nghttp2/nghttp2_info.md#h2load-load-testing-tool-for-spdy-and-http2)

nghttp2 configuration and compile parameters
=========================================

    PKG_CONFIG_PATH=/usr/local/http2-15/lib/pkgconfig ./configure --prefix=/usr/local/http2-15 --enable-app --with-xml-prefix=/usr/local/http2-15 LIBSPDYLAY_CFLAGS="-I/usr/local/http-15/include" LIBSPDYLAY_LIBS="-L/usr/local/http-15/lib -lspdylay" ZLIB_CFLAGS="-I/usr/local/http2-15/include" ZLIB_LIBS="-L/usr/local/http-15/lib" CFLAGS="-I/usr/local/http2-15/include" CXXFLAGS="-I/usr/local/http2-15/include" LDFLAGS="-L/usr/local/http2-15/lib" PYTHON_VERSION=2.7 PYTHON_CPPFLAGS="-I/usr/local/include/python2.7" PYTHON_LDFLAGS="-L/usr/local/lib -lpython2.7"

    configure: summary of build options:

    Version:        0.7.8-DEV shared 12:0:7
    Host type:      x86_64-unknown-linux-gnu
    Install prefix: /usr/local/http2-15
    C compiler:     ccache gcc
    CFLAGS:         -I/usr/local/http2-15/include
    WARNCFLAGS:     
    LDFLAGS:        -L/usr/local/http2-15/lib
    LIBS:           
    CPPFLAGS:       
    C preprocessor: ccache gcc -E
    C++ compiler:   ccache g++
    CXXFLAGS:       -I/usr/local/http2-15/include -std=c++11
    CXXCPP:         ccache g++ -E
    Library types:  Shared=yes, Static=yes
    Python:
      Python:         /usr/local/bin/python2.7
      PYTHON_VERSION: 2.7
      pyexecdir:      
      Python-dev:     yes
      PYTHON_CPPFLAGS:-I/usr/local/include/python2.7
      PYTHON_LDFLAGS: -L/usr/local/lib -lpython2.7
      Cython:         cython
    Test:
      CUnit:          yes
      Failmalloc:     yes
    Libs:
      OpenSSL:        yes
      Libxml2:        yes
      Libev:          yes
      Libevent(SSL):  yes
      Spdylay:        yes
      Jansson:        yes
      Jemalloc:       yes
      Boost CPPFLAGS: 
      Boost LDFLAGS:  
      Boost::ASIO:    
      Boost::System:  
      Boost::Thread:  
    Features:
      Applications:   yes
      HPACK tools:    yes
      Libnghttp2_asio:no
      Examples:       yes
      Python bindings:yes
      Threading:      yes

nghttp client
=========================================

    /usr/local/http2-15/bin/nghttp -h
    Usage: nghttp [OPTIONS]... <URI>...
    HTTP/2 experimental client
    
      <URI>       Specify URI to access.
    Options:
      -v, --verbose
                  Print   debug   information   such  as   reception   and
                  transmission of frames and name/value pairs.  Specifying
                  this option multiple times increases verbosity.
      -n, --null-out
                  Discard downloaded data.
      -O, --remote-name
                  Save  download  data  in  the  current  directory.   The
                  filename is  dereived from URI.   If URI ends  with '/',
                  'index.html'  is used  as a  filename.  Not  implemented
                  yet.
      -t, --timeout=<SEC>
                  Timeout each request after <SEC> seconds.
      -w, --window-bits=<N>
                  Sets the stream level initial window size to 2**<N>-1.
      -W, --connection-window-bits=<N>
                  Sets  the  connection  level   initial  window  size  to
                  2**<N>-1.
      -a, --get-assets
                  Download assets  such as stylesheets, images  and script
                  files linked  from the downloaded resource.   Only links
                  whose  origins are  the same  with the  linking resource
                  will be downloaded.   nghttp prioritizes resources using
                  HTTP/2 dependency  based priority.  The  priority order,
                  from highest to lowest,  is html itself, css, javascript
                  and images.
      -s, --stat  Print statistics.
      -H, --header=<HEADER>
                  Add a header to the requests.  Example: -H':method: PUT'
      --trailer=<HEADER>
                  Add a trailer header to the requests.  <HEADER> must not
                  include pseudo header field  (header field name starting
                  with ':').  To  send trailer, one must use  -d option to
                  send request body.  Example: --trailer 'foo: bar'.
      --cert=<CERT>
                  Use  the specified  client certificate  file.  The  file
                  must be in PEM format.
      --key=<KEY> Use the  client private key  file.  The file must  be in
                  PEM format.
      -d, --data=<FILE>
                  Post FILE to server. If '-'  is given, data will be read
                  from stdin.
      -m, --multiply=<N>
                  Request each URI <N> times.  By default, same URI is not
                  requested twice.  This option disables it too.
      -u, --upgrade
                  Perform HTTP Upgrade for HTTP/2.  This option is ignored
                  if the request URI has https scheme.  If -d is used, the
                  HTTP upgrade request is performed with OPTIONS method.
      -p, --weight=<WEIGHT>
                  Sets priority group weight.  The valid value range is
                  [1, 256], inclusive.
                  Default: 16
      -M, --peer-max-concurrent-streams=<N>
                  Use  <N>  as  SETTINGS_MAX_CONCURRENT_STREAMS  value  of
                  remote endpoint as if it  is received in SETTINGS frame.
                  The default is large enough as it is seen as unlimited.
      -c, --header-table-size=<SIZE>
                  Specify decoder header table size.
      -b, --padding=<N>
                  Add at  most <N>  bytes to a  frame payload  as padding.
                  Specify 0 to disable padding.
      -r, --har=<FILE>
                  Output HTTP  transactions <FILE> in HAR  format.  If '-'
                  is given, data is written to stdout.
      --color     Force colored log output.
      --continuation
                  Send large header to test CONTINUATION.
      --no-content-length
                  Don't send content-length header field.
      --no-dep    Don't send dependency based priority hint to server.
      --dep-idle  Use idle streams as anchor nodes to express priority.
      --version   Display version information and exit.
      -h, --help  Display this help and exit.
    
      The <SIZE> argument is an integer and an optional unit (e.g., 10K is
      10 * 1024).  Units are K, M and G (powers of 1024).

nghttpd server
=========================================

    /usr/local/http2-15/bin/nghttpd -h
    Usage: nghttpd [OPTION]... <PORT> [<PRIVATE_KEY> <CERT>]
    HTTP/2 experimental server
    
      <PORT>      Specify listening port number.
      <PRIVATE_KEY>
                  Set  path  to  server's private  key.   Required  unless
                  --no-tls is specified.
      <CERT>      Set  path  to  server's  certificate.   Required  unless
                  --no-tls is specified.
    Options:
      -a, --address=<ADDR>
                  The address to bind to.  If not specified the default IP
                  address determined by getaddrinfo is used.
      -D, --daemon
                  Run in a background.  If -D is used, the current working
                  directory is  changed to '/'.  Therefore  if this option
                  is used, -d option must be specified.
      -V, --verify-client
                  The server  sends a client certificate  request.  If the
                  client did  not return  a certificate, the  handshake is
                  terminated.   Currently,  this  option just  requests  a
                  client certificate and does not verify it.
      -d, --htdocs=<PATH>
                  Specify document root.  If this option is not specified,
                  the document root is the current working directory.
      -v, --verbose
                  Print debug information  such as reception/ transmission
                  of frames and name/value pairs.
      --no-tls    Disable SSL/TLS.
      -c, --header-table-size=<SIZE>
                  Specify decoder header table size.
      --color     Force colored log output.
      -p, --push=<PATH>=<PUSH_PATH,...>
                  Push  resources <PUSH_PATH>s  when <PATH>  is requested.
                  This option  can be used repeatedly  to specify multiple
                  push  configurations.    <PATH>  and   <PUSH_PATH>s  are
                  relative  to   document  root.   See   --htdocs  option.
                  Example: -p/=/foo.png -p/doc=/bar.css
      -b, --padding=<N>
                  Add at  most <N>  bytes to a  frame payload  as padding.
                  Specify 0 to disable padding.
      -n, --workers=<N>
                  Set the number of worker threads.
                  Default: 1
      -e, --error-gzip
                  Make error response gzipped.
      --dh-param-file=<PATH>
                  Path to file that contains  DH parameters in PEM format.
                  Without  this   option,  DHE   cipher  suites   are  not
                  available.
      --early-response
                  Start sending response when request HEADERS is received,
                  rather than complete request is received.
      --trailer=<HEADER>
                  Add a trailer  header to a response.   <HEADER> must not
                  include pseudo header field  (header field name starting
                  with ':').  The  trailer is sent only if  a response has
                  body part.  Example: --trailer 'foo: bar'.
      --version   Display version information and exit.
      -h, --help  Display this help and exit.
    
      The <SIZE> argument is an integer and an optional unit (e.g., 10K is
      10 * 1024).  Units are K, M and G (powers of 1024).

nghttpx proxy
=========================================

    /usr/local/http2-15/bin/nghttpx -h 
    Usage: nghttpx [OPTIONS]... [<PRIVATE_KEY> <CERT>]
    A reverse proxy for HTTP/2, HTTP/1 and SPDY.
    
      <PRIVATE_KEY>
                  Set path  to server's private key.   Required unless -p,
                  --client or --frontend-no-tls are given.
      <CERT>      Set path  to server's certificate.  Required  unless -p,
                  --client or --frontend-no-tls are given.
    
    Options:
      The options are categorized into several groups.
    
    Connections:
      -b, --backend=<HOST,PORT>
                  Set  backend  host  and   port.   The  multiple  backend
                  addresses are  accepted by repeating this  option.  UNIX
                  domain socket  can be  specified by prefixing  path name
                  with "unix:" (e.g., unix:/var/run/backend.sock)
                  Default: 127.0.0.1,80
      -f, --frontend=<HOST,PORT>
                  Set  frontend  host and  port.   If  <HOST> is  '*',  it
                  assumes  all addresses  including  both  IPv4 and  IPv6.
                  UNIX domain  socket can  be specified by  prefixing path
                  name with "unix:" (e.g., unix:/var/run/nghttpx.sock)
                  Default: *,3000
      --backlog=<N>
                  Set listen backlog size.
                  Default: 512
      --backend-ipv4
                  Resolve backend hostname to IPv4 address only.
      --backend-ipv6
                  Resolve backend hostname to IPv6 address only.
      --backend-http-proxy-uri=<URI>
                  Specify      proxy       URI      in       the      form
                  http://[<USER>:<PASS>@]<PROXY>:<PORT>.    If   a   proxy
                  requires  authentication,  specify  <USER>  and  <PASS>.
                  Note that  they must be properly  percent-encoded.  This
                  proxy  is used  when the  backend connection  is HTTP/2.
                  First,  make  a CONNECT  request  to  the proxy  and  it
                  connects  to the  backend  on behalf  of nghttpx.   This
                  forms  tunnel.   After  that, nghttpx  performs  SSL/TLS
                  handshake with  the downstream through the  tunnel.  The
                  timeouts when connecting and  making CONNECT request can
                  be     specified    by     --backend-read-timeout    and
                  --backend-write-timeout options.
    
    Performance:
      -n, --workers=<N>
                  Set the number of worker threads.
                  Default: 1
      --read-rate=<SIZE>
                  Set maximum  average read  rate on  frontend connection.
                  Setting 0 to this option means read rate is unlimited.
                  Default: 0
      --read-burst=<SIZE>
                  Set  maximum read  burst  size  on frontend  connection.
                  Setting  0  to this  option  means  read burst  size  is
                  unlimited.
                  Default: 0
      --write-rate=<SIZE>
                  Set maximum  average write rate on  frontend connection.
                  Setting 0 to this option means write rate is unlimited.
                  Default: 0
      --write-burst=<SIZE>
                  Set  maximum write  burst size  on frontend  connection.
                  Setting  0 to  this  option means  write  burst size  is
                  unlimited.
                  Default: 0
      --worker-read-rate=<SIZE>
                  Set maximum average read rate on frontend connection per
                  worker.  Setting  0 to  this option  means read  rate is
                  unlimited.  Not implemented yet.
                  Default: 0
      --worker-read-burst=<SIZE>
                  Set maximum  read burst size on  frontend connection per
                  worker.  Setting 0 to this  option means read burst size
                  is unlimited.  Not implemented yet.
                  Default: 0
      --worker-write-rate=<SIZE>
                  Set maximum  average write  rate on  frontend connection
                  per worker.  Setting  0 to this option  means write rate
                  is unlimited.  Not implemented yet.
                  Default: 0
      --worker-write-burst=<SIZE>
                  Set maximum write burst  size on frontend connection per
                  worker.  Setting 0 to this option means write burst size
                  is unlimited.  Not implemented yet.
                  Default: 0
      --worker-frontend-connections=<N>
                  Set maximum number  of simultaneous connections frontend
                  accepts.  Setting 0 means unlimited.
                  Default: 0
      --backend-http2-connections-per-worker=<N>
                  Set  maximum number  of HTTP/2  connections per  worker.
                  The  default  value is  0,  which  means the  number  of
                  backend addresses specified by -b option.
      --backend-http1-connections-per-host=<N>
                  Set   maximum  number   of  backend   concurrent  HTTP/1
                  connections per host.  This option is meaningful when -s
                  option is used.  To limit  the number of connections per
                  frontend        for       default        mode,       use
                  --backend-http1-connections-per-frontend.
                  Default: 8
      --backend-http1-connections-per-frontend=<N>
                  Set   maximum  number   of  backend   concurrent  HTTP/1
                  connections per frontend.  This  option is only used for
                  default mode.   0 means unlimited.  To  limit the number
                  of connections  per host for  HTTP/2 or SPDY  proxy mode
                  (-s option), use --backend-http1-connections-per-host.
                  Default: 0
      --rlimit-nofile=<N>
                  Set maximum number of open files (RLIMIT_NOFILE) to <N>.
                  If 0 is given, nghttpx does not set the limit.
                  Default: 0
      --backend-request-buffer=<SIZE>
                  Set buffer size used to store backend request.
                  Default: 16K
      --backend-response-buffer=<SIZE>
                  Set buffer size used to store backend response.
                  Default: 16K
    
    Timeout:
      --frontend-http2-read-timeout=<DURATION>
                  Specify  read  timeout  for  HTTP/2  and  SPDY  frontend
                  connection.
                  Default: 180s
      --frontend-read-timeout=<DURATION>
                  Specify read timeout for HTTP/1.1 frontend connection.
                  Default: 180s
      --frontend-write-timeout=<DURATION>
                  Specify write timeout for all frontend connections.
                  Default: 30s
      --stream-read-timeout=<DURATION>
                  Specify  read timeout  for HTTP/2  and SPDY  streams.  0
                  means no timeout.
                  Default: 0
      --stream-write-timeout=<DURATION>
                  Specify write  timeout for  HTTP/2 and SPDY  streams.  0
                  means no timeout.
                  Default: 0
      --backend-read-timeout=<DURATION>
                  Specify read timeout for backend connection.
                  Default: 180s
      --backend-write-timeout=<DURATION>
                  Specify write timeout for backend connection.
                  Default: 30s
      --backend-keep-alive-timeout=<DURATION>
                  Specify keep-alive timeout for backend connection.
                  Default: 2s
      --listener-disable-timeout=<DURATION>
                  After accepting  connection failed,  connection listener
                  is disabled  for a given  amount of time.   Specifying 0
                  disables this feature.
                  Default: 0
    
    SSL/TLS:
      --ciphers=<SUITE>
                  Set allowed  cipher list.  The  format of the  string is
                  described in OpenSSL ciphers(1).
      -k, --insecure
                  Don't  verify   backend  server's  certificate   if  -p,
                  --client    or    --http2-bridge     are    given    and
                  --backend-no-tls is not given.
      --cacert=<PATH>
                  Set path to trusted CA  certificate file if -p, --client
                  or --http2-bridge are given  and --backend-no-tls is not
                  given.  The file must be  in PEM format.  It can contain
                  multiple  certificates.    If  the  linked   OpenSSL  is
                  configured to  load system  wide certificates,  they are
                  loaded at startup regardless of this option.
      --private-key-passwd-file=<PATH>
                  Path  to file  that contains  password for  the server's
                  private key.   If none is  given and the private  key is
                  password protected it'll be requested interactively.
      --subcert=<KEYPATH>:<CERTPATH>
                  Specify  additional certificate  and  private key  file.
                  nghttpx will  choose certificates based on  the hostname
                  indicated  by  client  using TLS  SNI  extension.   This
                  option can be used multiple times.
      --backend-tls-sni-field=<HOST>
                  Explicitly  set the  content of  the TLS  SNI extension.
                  This will default to the backend HOST name.
      --dh-param-file=<PATH>
                  Path to file that contains  DH parameters in PEM format.
                  Without  this   option,  DHE   cipher  suites   are  not
                  available.
      --npn-list=<LIST>
                  Comma delimited list of  ALPN protocol identifier sorted
                  in the  order of preference.  That  means most desirable
                  protocol comes  first.  This  is used  in both  ALPN and
                  NPN.  The parameter must be  delimited by a single comma
                  only  and any  white spaces  are  treated as  a part  of
                  protocol string.
                  Default: h2,h2-16,h2-14,spdy/3.1,http/1.1
      --verify-client
                  Require and verify client certificate.
      --verify-client-cacert=<PATH>
                  Path  to file  that contains  CA certificates  to verify
                  client certificate.  The file must be in PEM format.  It
                  can contain multiple certificates.
      --client-private-key-file=<PATH>
                  Path to  file that contains  client private key  used in
                  backend client authentication.
      --client-cert-file=<PATH>
                  Path to  file that  contains client certificate  used in
                  backend client authentication.
      --tls-proto-list=<LIST>
                  Comma delimited list of  SSL/TLS protocol to be enabled.
                  The following protocols  are available: TLSv1.2, TLSv1.1
                  and   TLSv1.0.    The   name   matching   is   done   in
                  case-insensitive   manner.    The  parameter   must   be
                  delimited by  a single comma  only and any  white spaces
                  are treated as a part of protocol string.
                  Default: TLSv1.2,TLSv1.1
      --tls-ticket-key-file=<PATH>
                  Path  to file  that  contains 48  bytes  random data  to
                  construct TLS  session ticket parameters.   This options
                  can  be  used  repeatedly  to  specify  multiple  ticket
                  parameters.  If several files  are given, only the first
                  key is used to encrypt  TLS session tickets.  Other keys
                  are accepted  but server  will issue new  session ticket
                  with  first  key.   This allows  session  key  rotation.
                  Please   note  that   key   rotation   does  not   occur
                  automatically.   User should  rearrange files  or change
                  options  values  and  restart  nghttpx  gracefully.   If
                  opening or reading given file fails, all loaded keys are
                  discarded and it is treated as if none of this option is
                  given.  If this option is not given or an error occurred
                  while  opening  or  reading  a file,  key  is  generated
                  automatically and  renewed every 12hrs.  At  most 2 keys
                  are stored in memory.
      --tls-ctx-per-worker
                  Create OpenSSL's SSL_CTX per worker, so that no internal
                  locking is required.  This  may improve scalability with
                  multi  threaded   configuration.   If  this   option  is
                  enabled, session ID is  no longer shared accross SSL_CTX
                  objects, which means session  ID generated by one worker
                  is not acceptable by another worker.  On the other hand,
                  session ticket key is shared across all worker threads.
    
    HTTP/2 and SPDY:
      -c, --http2-max-concurrent-streams=<N>
                  Set the maximum number of  the concurrent streams in one
                  HTTP/2 and SPDY session.
                  Default: 100
      --frontend-http2-window-bits=<N>
                  Sets the  per-stream initial window size  of HTTP/2 SPDY
                  frontend connection.  For HTTP/2,  the size is 2**<N>-1.
                  For SPDY, the size is 2**<N>.
                  Default: 16
      --frontend-http2-connection-window-bits=<N>
                  Sets the  per-connection window size of  HTTP/2 and SPDY
                  frontend   connection.    For   HTTP/2,  the   size   is
                  2**<N>-1. For SPDY, the size is 2**<N>.
                  Default: 16
      --frontend-no-tls
                  Disable SSL/TLS on frontend connections.
      --backend-http2-window-bits=<N>
                  Sets  the   initial  window   size  of   HTTP/2  backend
                  connection to 2**<N>-1.
                  Default: 16
      --backend-http2-connection-window-bits=<N>
                  Sets the  per-connection window  size of  HTTP/2 backend
                  connection to 2**<N>-1.
                  Default: 16
      --backend-no-tls
                  Disable SSL/TLS on backend connections.
      --http2-no-cookie-crumbling
                  Don't crumble cookie header field.
      --padding=<N>
                  Add  at most  <N> bytes  to  a HTTP/2  frame payload  as
                  padding.  Specify 0 to  disable padding.  This option is
                  meant for debugging purpose  and not intended to enhance
                  protocol security.
      --no-server-push
                  Disable  HTTP/2  server  push.    Server  push  is  only
                  supported  by default  mode and  HTTP/2 frontend.   SPDY
                  frontend does not support server push.
    
    Mode:
      (default mode)
                  Accept  HTTP/2,  SPDY  and HTTP/1.1  over  SSL/TLS.   If
                  --frontend-no-tls is  used, accept HTTP/2  and HTTP/1.1.
                  The  incoming HTTP/1.1  connection  can  be upgraded  to
                  HTTP/2  through  HTTP  Upgrade.   The  protocol  to  the
                  backend is HTTP/1.1.
      -s, --http2-proxy
                  Like default mode, but enable secure proxy mode.
      --http2-bridge
                  Like default  mode, but communicate with  the backend in
                  HTTP/2 over SSL/TLS.  Thus  the incoming all connections
                  are converted  to HTTP/2  connection and relayed  to the
                  backend.  See --backend-http-proxy-uri option if you are
                  behind  the proxy  and want  to connect  to the  outside
                  HTTP/2 proxy.
      --client    Accept  HTTP/2   and  HTTP/1.1  without   SSL/TLS.   The
                  incoming HTTP/1.1  connection can be upgraded  to HTTP/2
                  connection through  HTTP Upgrade.   The protocol  to the
                  backend is HTTP/2.   To use nghttpx as  a forward proxy,
                  use -p option instead.
      -p, --client-proxy
                  Like --client  option, but it also  requires the request
                  path from frontend must be an absolute URI, suitable for
                  use as a forward proxy.
    
    Logging:
      -L, --log-level=<LEVEL>
                  Set the severity  level of log output.   <LEVEL> must be
                  one of INFO, NOTICE, WARN, ERROR and FATAL.
                  Default: NOTICE
      --accesslog-file=<PATH>
                  Set path to write access log.  To reopen file, send USR1
                  signal to nghttpx.
      --accesslog-syslog
                  Send  access log  to syslog.   If this  option is  used,
                  --accesslog-file option is ignored.
      --accesslog-format=<FORMAT>
                  Specify  format  string  for access  log.   The  default
                  format is combined format.   The following variables are
                  available:
    
                  * $remote_addr: client IP address.
                  * $time_local: local time in Common Log format.
                  * $time_iso8601: local time in ISO 8601 format.
                  * $request: HTTP request line.
                  * $status: HTTP response status code.
                  * $body_bytes_sent: the  number of bytes sent  to client
                    as response body.
                  * $http_<VAR>: value of HTTP  request header <VAR> where
                    '_' in <VAR> is replaced with '-'.
                  * $remote_port: client  port.
                  * $server_port: server port.
                  * $request_time: request processing time in seconds with
                    milliseconds resolution.
                  * $pid: PID of the running process.
                  * $alpn: ALPN identifier of the protocol which generates
                    the response.   For HTTP/1,  ALPN is  always http/1.1,
                    regardless of minor version.
    
                  Default: $remote_addr - - [$time_local] "$request" $status $body_bytes_sent "$http_referer" "$http_user_agent"
      --errorlog-file=<PATH>
                  Set path to write error  log.  To reopen file, send USR1
                  signal to nghttpx.
                  Default: /dev/stderr
      --errorlog-syslog
                  Send  error log  to  syslog.  If  this  option is  used,
                  --errorlog-file option is ignored.
      --syslog-facility=<FACILITY>
                  Set syslog facility to <FACILITY>.
                  Default: daemon
    
    HTTP:
      --add-x-forwarded-for
                  Append  X-Forwarded-For header  field to  the downstream
                  request.
      --strip-incoming-x-forwarded-for
                  Strip X-Forwarded-For  header field from  inbound client
                  requests.
      --no-via    Don't append to  Via header field.  If  Via header field
                  is received, it is left unaltered.
      --no-location-rewrite
                  Don't rewrite  location header field  on --http2-bridge,
                  --client  and  default   mode.   For  --http2-proxy  and
                  --client-proxy mode,  location header field will  not be
                  altered regardless of this option.
      --no-host-rewrite
                  Don't  rewrite  host  and :authority  header  fields  on
                  --http2-bridge,   --client   and  default   mode.    For
                  --http2-proxy  and  --client-proxy mode,  these  headers
                  will not be altered regardless of this option.
      --altsvc=<PROTOID,PORT[,HOST,[ORIGIN]]>
                  Specify   protocol  ID,   port,  host   and  origin   of
                  alternative service.  <HOST>  and <ORIGIN> are optional.
                  They are  advertised in  alt-svc header field  or HTTP/2
                  ALTSVC frame.  This option can be used multiple times to
                  specify   multiple   alternative   services.    Example:
                  --altsvc=h2,443
      --add-response-header=<HEADER>
                  Specify  additional  header  field to  add  to  response
                  header set.   This option just appends  header field and
                  won't replace anything already  set.  This option can be
                  used several  times to  specify multiple  header fields.
                  Example: --add-response-header="foo: bar"
    
    Debug:
      --frontend-http2-dump-request-header=<PATH>
                  Dumps request headers received by HTTP/2 frontend to the
                  file denoted  in <PATH>.  The  output is done  in HTTP/1
                  header field format and each header block is followed by
                  an empty line.  This option  is not thread safe and MUST
                  NOT be used with option -n<N>, where <N> >= 2.
      --frontend-http2-dump-response-header=<PATH>
                  Dumps response headers sent  from HTTP/2 frontend to the
                  file denoted  in <PATH>.  The  output is done  in HTTP/1
                  header field format and each header block is followed by
                  an empty line.  This option  is not thread safe and MUST
                  NOT be used with option -n<N>, where <N> >= 2.
      -o, --frontend-frame-debug
                  Print HTTP/2 frames in  frontend to stderr.  This option
                  is  not thread  safe and  MUST NOT  be used  with option
                  -n=N, where N >= 2.
    
    Process:
      -D, --daemon
                  Run in a background.  If -D is used, the current working
                  directory is changed to '/'.
      --pid-file=<PATH>
                  Set path to save PID of this program.
      --user=<USER>
                  Run this program as <USER>.   This option is intended to
                  be used to drop root privileges.
    
    Misc:
      --conf=<PATH>
                  Load configuration from <PATH>.
                  Default: /etc/nghttpx/nghttpx.conf
      -v, --version
                  Print version and exit.
      -h, --help  Print this help and exit.
    
      The <SIZE> argument is an integer and an optional unit (e.g., 10K is
      10 * 1024).  Units are K, M and G (powers of 1024).
    
      The <DURATION> argument is an integer and an optional unit (e.g., 1s
      is 1 second and 500ms is 500  milliseconds).  Units are s or ms.  If
      a unit is omitted, a second is used as unit.

h2load load testing tool for SPDY and HTTP/2
=========================================

    /usr/local/http2-15/bin/h2load -h       
    Usage: h2load [OPTIONS]... [URI]...
    benchmarking tool for HTTP/2 and SPDY server
    
      <URI>       Specify URI to access.   Multiple URIs can be specified.
                  URIs are used  in this order for each  client.  All URIs
                  are used, then  first URI is used and then  2nd URI, and
                  so  on.  The  scheme, host  and port  in the  subsequent
                  URIs, if present,  are ignored.  Those in  the first URI
                  are used solely.
    Options:
      -n, --requests=<N>
                  Number of requests.
                  Default: 1
      -c, --clients=<N>
                  Number of concurrent clients.
                  Default: 1
      -t, --threads=<N>
                  Number of native threads.
                  Default: 1
      -i, --input-file=<FILE>
                  Path of a file with multiple URIs are seperated by EOLs.
                  This option will disable URIs getting from command-line.
                  If '-' is given as <FILE>, URIs will be read from stdin.
                  URIs are used  in this order for each  client.  All URIs
                  are used, then  first URI is used and then  2nd URI, and
                  so  on.  The  scheme, host  and port  in the  subsequent
                  URIs, if present,  are ignored.  Those in  the first URI
                  are used solely.
      -m, --max-concurrent-streams=(auto|<N>)
                  Max concurrent streams to  issue per session.  If "auto"
                  is given, the number of given URIs is used.
                  Default: auto
      -w, --window-bits=<N>
                  Sets the stream level initial window size to (2**<N>)-1.
                  For SPDY, 2**<N> is used instead.
      -W, --connection-window-bits=<N>
                  Sets  the  connection  level   initial  window  size  to
                  (2**<N>)-1.  For SPDY, if <N>  is strictly less than 16,
                  this option  is ignored.   Otherwise 2**<N> is  used for
                  SPDY.
      -H, --header=<HEADER>
                  Add/Override a header to the requests.
      -p, --no-tls-proto=<PROTOID>
                  Specify ALPN identifier of the  protocol to be used when
                  accessing http URI without SSL/TLS.
                  Available protocols: spdy/2, spdy/3, spdy/3.1 and h2c-14
                  Default: h2c-14
      -v, --verbose
                  Output debug information.
      --version   Display version information and exit.
      -h, --help  Display this help and exit.