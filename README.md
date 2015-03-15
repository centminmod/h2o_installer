[h2o http server](https://github.com/h2o/h2o) installer script for integrating h2o into centminmod.com LEMP web stack

start h2o server

    start_server --port 0.0.0.0:8080 --port 0.0.0.0:8081 --pid-file=/var/run/h2o.pid --status-file=/usr/local/h2o/h2o_status -- /usr/local/bin/h2o -c /usr/local/h2o/h2o.conf &
    [1] 25673
    start_server (pid:25673) starting now...
    starting new worker 25674
    [INFO] raised RLIMIT_NOFILE to 262144
    h2o server (pid:25674) is ready to serve requests
    fetch-ocsp-response (using OpenSSL 1.0.1e-fips 11 Feb 2013)
    fetch-ocsp-response (using OpenSSL 1.0.1e-fips 11 Feb 2013)
    failed to extract ocsp URI from /usr/local/h2o/alternate.crt
    failed to extract ocsp URI from /usr/local/h2o/server.crt
    [OCSP Stapling] disabled for certificate file:/usr/local/h2o/server.crt
    [OCSP Stapling] disabled for certificate file:/usr/local/h2o/alternate.crt

header check

    curl -I localhost:8080/index.html
    HTTP/1.1 200 OK
    Date: Sun, 15 Mar 2015 23:50:21 GMT
    Server: h2o/1.1.1
    Connection: keep-alive
    Content-Length: 3801
    content-type: text/html
    last-modified: Sat, 14 Mar 2015 19:15:28 GMT
    etag: "550488d0-ed9"
