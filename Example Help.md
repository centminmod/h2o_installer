    h2o -h
    h2o version 1.1.1
    
    Usage:
      h2o [options]
    
    Options:
      -c, --conf FILE  configuration file (default: h2o.conf)
      -t, --test       tests the configuration
      -v, --version    prints the version number
      -h, --help       print this help
    
    Configuration File:
      The configuration file should be written in YAML format.  Below is the list
      of configuration directives; the flags indicate at which level the directives
      can be used; g=global, h=host, p=path.
    
      hosts: [g]
        map of `host[:port]` -> map of per-host configs
      paths: [h]
        map of URL-path -> configuration
    
      limit-request-body: [g]
        maximum size of request body in bytes (e.g. content of POST)
        (default: unlimited)
      max-delegations: [g]
        limits the number of delegations (i.e. internal redirects using the
        `X-Reproxy-URL` header) (default: 5)
      http1-request-timeout: [g]
        timeout for incoming requests in seconds (default: 10)
      http1-upgrade-to-http2: [g]
        boolean flag (ON/OFF) indicating whether or not to allow upgrade to HTTP/2
        (default: ON)
      http2-idle-timeout: [g]
        timeout for idle connections in seconds (default: 10)
      http2-max-concurrent-requests-per-connection: [g]
        max. number of requests to be handled concurrently within a single HTTP/2
        stream (default: 16)
    
      listen: [gh]
        port at which the server should listen for incoming requests (mandatory)
         - if the value is a scalar, it is treated as the port number (or as the
           service name)
         - if the value is a mapping, following properties are recognized:
             port: incoming port number or service name (mandatory)
             host: incoming address (default: any address)
             ssl: mapping of SSL configuration using the keys below (default: none)
               certificate-file: path of the SSL certificate file (mandatory)
               key-file:         path of the SSL private key file (mandatory)
               minimum-version:  minimum protocol version, should be one of: SSLv2,
                                 SSLv3, TLSv1, TLSv1.1, TLSv1.2 (default: TLSv1)
               cipher-suite:     list of cipher suites to be passed to OpenSSL via
                                 SSL_CTX_set_cipher_list (optional)
               dh-file:          PEM file of dhparam to use (optional)
               ocsp-update-interval:
                                 interval for updating the OCSP stapling data (in
                                 seconds), or set to zero to disable OCSP stapling
                                 (default: 14400 = 4 hours)
               ocsp-max-failures:
                                 number of consecutive OCSP queriy failures before
                                 stopping to send OCSP stapling data to the client
                                 (default: 3)
         - if the value is a sequence, each element should be either a scalar or a
           mapping that conform to the requirements above
    
      user: [g]
        user under with the server should handle incoming requests (default: none)
      pid-file: [g]
        name of the pid file (default: none)
      max-connections: [g]
        max connections (default: 1024)
      num-threads: [g]
        number of worker threads (default: getconf NPROCESSORS_ONLN)
      num-name-resolution-threads: [g]
        number of threads to run for name resolution (default: 32)
    
      access-log: [ghp]
        path and optionally the format of the access log (default: none)
          - if the value is a scalar, it is treated as the path of the log file
          - if the value is a mapping, its `path` property is treated as the path
            and `format` property is treated as the format
          - if the path starts with `|`, the rest of the path is considered as a 
            command pipe to which the logs should be emitted
        following format strings are recognized:
          %h:         remote host
          %l:         remote logname (always '-')
          %u:         remote user (always '-')
          %t:         request time
          %r:         first line of request
          %s:         status
          %b:         size of the response body in bytes
          %{Foobar}i: the contents of the request header `Foobar`
          %{Foobar}o: the contents of the response header `Foobar`
    
      expires: [ghp]
        sets `Cache-Control: max-age` header (default: OFF)
          - if the value is `OFF` then the feature is not used
          - if the value is `<number> <unit>` then the header is set
          - the units recognized are: `second`,`minute`,`hour`,`day`,`month`,`year`
          - the units can also be in plural forms
        example: `expires: 1 day` sets `Cache-Control: max-age=86400`
    
      file.dir: [p]
        directory under which to serve the target path
      file.index: [ghp]
        sequence of index file names (default: index.html index.htm index.txt)
      file.mime.settypes: [ghp]
        map of mime-type -> (extension | sequence-of-extensions)
      file.mime.addtypes: [ghp]
        map of mime-type -> (extension | sequence-of-extensions)
      file.mime.removetypes: [ghp]
        sequence of extensions
      file.mime.setdefaulttype: [ghp]
        default mime-type
      file.etag: [ghp]
        whether or not to send etag (ON or OFF, default: ON)
      file.send-gzip: [ghp]
        whether or not to send .gz variants if possible (ON or OFF, default: OFF)
      file.dirlisting: [ghp]
        whether or not to send directory indexes (ON or OFF, default: OFF)
    
      header.add: [ghp]
        adds a new header line to the response headers
      header.append: [ghp]
        adds a new header line, or appends the value to the existing header with
        the same name (separated by `,`)
      header.merge: [ghp]
        adds a new header line, or merges the value to the existing header of
        comma-separated values
      header.set: [ghp]
        sets a header line, removing headers with the same name (if exist)
      header.setifempty: [ghp]
        sets a header line, only when a header with the same name does not exist
      header.unset: [ghp]
        removes headers with the specified name
    
      proxy.reverse.url: [p]
        upstream URL (only HTTP is suppported)
      proxy.preserve-host: [ghp]
        boolean flag (ON/OFF) indicating whether or not to pass Host header
        from imcoming request to upstream (default: OFF)
      proxy.timeout.io: [ghp]
        sets upstream I/O timeout (in milliseconds, default: (5 * 1000))
      proxy.timeout.keepalive: [ghp]
        timeout for idle conncections (set to zero to disable persistent connections
        upstream; in milliseconds, default: 2000)
    
      reproxy: [ghp]
        boolean flag (ON/OFF) indicating whether or not to accept Reproxy-URL
        response headers from upstream (default: OFF)
    
      redirect: [p]
        redirects the request to given URL prefix
         - if the value is a scalar, it is considered as the destination URL prefix
         - if the value is a mapping, it should contain the following properties:
             status: HTTP status code to be sent (e.g. 301)
             url:    the destination URL prefix