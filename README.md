[h2o http server](https://github.com/h2o/h2o) installer script for integrating h2o into centminmod.com LEMP web stack

More info on HTTP/2 at [http://http2rulez.com/](http://http2rulez.com/)

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

header check for http on port 8080

    curl -I http://localhost:8080/index.html
    HTTP/1.1 200 OK
    Date: Sun, 15 Mar 2015 23:50:21 GMT
    Server: h2o/1.1.1
    Connection: keep-alive
    Content-Length: 3801
    content-type: text/html
    last-modified: Sat, 14 Mar 2015 19:15:28 GMT
    etag: "550488d0-ed9"

header check for https on port 8081

    curl -kI https://localhost:8081/index.html
    HTTP/1.1 200 OK
    Date: Sun, 15 Mar 2015 23:55:28 GMT
    Server: h2o/1.1.1
    Connection: keep-alive
    Content-Length: 3801
    content-type: text/html
    last-modified: Sat, 14 Mar 2015 19:15:28 GMT
    etag: "550488d0-ed9"

Chrome web browser reported working HTTP/2 support on CentminMod.com LEMP stack's H2O server integration

![HTTP/2 enabled support in Chrome Browser for CentminMod.com stack's H2O server integration](http://centminmod.com/h2o/screenshots/http2/h2o_111_http2_enabled_chrome_00.png "HTTP/2 enabled support in Chrome Browser for CentminMod.com stack's H2O server integration")

Opera 28 developer tools with SPDY/4 chrome flag enabled for H2-14 = HTTP/2 draft 14

![Opera 28 dev tools H2-14 protocol](http://centminmod.com/h2o/screenshots/http2/h2o_111_http2_enabled_opera28_01.png "Opera 28 dev tools H2-14 protocol")

Example H2O SSL setup with Comodo SSL Wildcard certificate

`/usr/local/h2o/centminmod.com-unified.crt` created using concatenated 

    cat yourdomain.crt intermediate.crt root.pem > /usr/local/h2o/centminmod.com-unified.crt

example SSL config

    listen:
      host: 0.0.0.0
      port: 8081
      ssl:
        certificate-file: /usr/local/h2o/centminmod.com-unified.crt
        key-file: /usr/local/h2o/centminmod.com.key
        minimum-version: TLSv1
        cipher-suite: ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-AES256-GCM-SHA384:DHE-RSA-AES128-GCM-SHA256:DHE-DSS-AES128-GCM-SHA256:kEDH+AESGCM:ECDHE-RSA-AES128-SHA256:ECDHE-ECDSA-AES128-SHA256:ECDHE-RSA-AES128-SHA:ECDHE-ECDSA-AES128-SHA:ECDHE-RSA-AES256-SHA384:ECDHE-ECDSA-AES256-SHA384:ECDHE-RSA-AES256-SHA:ECDHE-ECDSA-AES256-SHA:DHE-RSA-AES128-SHA256:DHE-RSA-AES128-SHA:DHE-DSS-AES128-SHA256:DHE-RSA-AES256-SHA256:DHE-DSS-AES256-SHA:DHE-RSA-AES256-SHA:AES128-GCM-SHA256:AES256-GCM-SHA384:AES128-SHA256:AES256-SHA256:AES128-SHA:AES256-SHA:AES:CAMELLIA:DES-CBC3-SHA:!aNULL:!eNULL:!EXPORT:!DES:!RC4:!MD5:!PSK:!aECDH:!EDH-DSS-DES-CBC3-SHA:!EDH-RSA-DES-CBC3-SHA:!KRB5-DES-CBC3-SHA:!CAMELLIA

check https SSL on port 8081 for H20 server using [cipherscan](https://github.com/jvehent/cipherscan)

    ./cipherscan XXX.centminmod.com:8081        
    ..............
    Target: XXX.centminmod.com:8081
    
    prio  ciphersuite                  protocols              pfs_keysize
    1     ECDHE-RSA-AES256-GCM-SHA384  TLSv1.2                ECDH,P-256,256bits
    2     ECDHE-RSA-AES256-SHA384      TLSv1.2                ECDH,P-256,256bits
    3     ECDHE-RSA-AES256-SHA         TLSv1,TLSv1.1,TLSv1.2  ECDH,P-256,256bits
    4     AES256-GCM-SHA384            TLSv1.2
    5     AES256-SHA256                TLSv1.2
    6     AES256-SHA                   TLSv1,TLSv1.1,TLSv1.2
    7     ECDHE-RSA-AES128-GCM-SHA256  TLSv1.2                ECDH,P-256,256bits
    8     ECDHE-RSA-AES128-SHA256      TLSv1.2                ECDH,P-256,256bits
    9     ECDHE-RSA-AES128-SHA         TLSv1,TLSv1.1,TLSv1.2  ECDH,P-256,256bits
    10    AES128-GCM-SHA256            TLSv1.2
    11    AES128-SHA256                TLSv1.2
    12    AES128-SHA                   TLSv1,TLSv1.1,TLSv1.2
    13    DES-CBC3-SHA                 TLSv1,TLSv1.1,TLSv1.2
    
    Certificate: trusted, 2048 bit, sha256WithRSAEncryption signature
    TLS ticket lifetime hint: 300
    OCSP stapling: supported
    Client side cipher ordering

compared to Centmin Mod Nginx SPDY setup with OpenSSL 1.0.2 chacha20_poly1305 cipher patched on [https://community.centminmod.com](https://community.centminmod.com)

    ./cipherscan community.centminmod.com:443       
    ........
    Target: community.centminmod.com:443
    
    prio  ciphersuite                  protocols              pfs_keysize
    1     ECDHE-RSA-CHACHA20-POLY1305  TLSv1.2                ECDH,P-256,256bits
    2     ECDHE-RSA-AES256-GCM-SHA384  TLSv1.2                ECDH,P-256,256bits
    3     ECDHE-RSA-AES256-SHA384      TLSv1.2                ECDH,P-256,256bits
    4     ECDHE-RSA-AES256-SHA         TLSv1,TLSv1.1,TLSv1.2  ECDH,P-256,256bits
    5     DHE-RSA-AES256-GCM-SHA384    TLSv1.2                DH,4096bits
    6     DHE-RSA-AES256-SHA256        TLSv1.2                DH,4096bits
    7     DHE-RSA-AES256-SHA           TLSv1,TLSv1.1,TLSv1.2  DH,4096bits
    
    Certificate: trusted, 2048 bit, sha256WithRSAEncryption signature
    TLS ticket lifetime hint: 43200
    OCSP stapling: supported
    Server side cipher ordering

Using OpenSSL 1.0.2 static compiled client to check h2o SSL server for ALPN and NPN TLS extension support

check for ALPN extension support in h2o server

    /opt/h2o_openssl/bin/openssl s_client -alpn h2-14 -host XXX.centminmod.com -port 8081
    CONNECTED(00000003)
    
    ---
    New, TLSv1/SSLv3, Cipher is ECDHE-RSA-AES256-GCM-SHA384
    Server public key is 2048 bit
    Secure Renegotiation IS supported
    Compression: NONE
    Expansion: NONE
    ALPN protocol: h2-14
    SSL-Session:
        Protocol  : TLSv1.2
        Cipher    : ECDHE-RSA-AES256-GCM-SHA384

check for NPN extension support in h2o server

    /opt/h2o_openssl/bin/openssl s_client -nextprotoneg h2-14 -host XXX.centminmod.com -port 8081
    
    ---
    New, TLSv1/SSLv3, Cipher is ECDHE-RSA-AES256-GCM-SHA384
    Server public key is 2048 bit
    Secure Renegotiation IS supported
    Compression: NONE
    Expansion: NONE
    Next protocol: (1) h2-14
    No ALPN negotiated

Using nghttp2 client to check h2o SSL server on port 8081 for HTTP/2 support = negotiated protocoal = h2

    /usr/local/http2-15/bin/nghttp -nv https://XXX.centminmod.com:8081
    [  0.000] Connected
    The negotiated protocol: h2
    [  0.003] send SETTINGS frame <length=12, flags=0x00, stream_id=0>
              (niv=2)
              [SETTINGS_MAX_CONCURRENT_STREAMS(0x03):100]
              [SETTINGS_INITIAL_WINDOW_SIZE(0x04):65535]
    [  0.003] send HEADERS frame <length=45, flags=0x05, stream_id=1>
              ; END_STREAM | END_HEADERS
              (padlen=0)
              ; Open new stream
              :method: GET
              :path: /
              :scheme: https
              :authority: XXX.centminmod.com:8081
              accept: */*
              accept-encoding: gzip, deflate
              user-agent: nghttp2/0.7.8-DEV
    [  0.003] recv SETTINGS frame <length=18, flags=0x00, stream_id=0>
              (niv=3)
              [SETTINGS_ENABLE_PUSH(0x02):0]
              [SETTINGS_MAX_CONCURRENT_STREAMS(0x03):100]
              [SETTINGS_INITIAL_WINDOW_SIZE(0x04):262144]
    [  0.003] send SETTINGS frame <length=0, flags=0x01, stream_id=0>
              ; ACK
              (niv=0)
    [  0.003] recv SETTINGS frame <length=0, flags=0x01, stream_id=0>
              ; ACK
              (niv=0)
    [  0.003] recv (stream_id=1) :status: 200
    [  0.003] recv (stream_id=1) server: h2o/1.1.1
    [  0.003] recv (stream_id=1) date: Wed, 18 Mar 2015 02:36:16 GMT
    [  0.003] recv (stream_id=1) content-type: text/html
    [  0.003] recv (stream_id=1) last-modified: Sat, 14 Mar 2015 19:15:28 GMT
    [  0.003] recv (stream_id=1) etag: "550488d0-ed9"
    [  0.003] recv HEADERS frame <length=81, flags=0x04, stream_id=1>
              ; END_HEADERS
              (padlen=0)
              ; First response header
    [  0.003] recv DATA frame <length=3801, flags=0x01, stream_id=1>
              ; END_STREAM
    [  0.003] send GOAWAY frame <length=8, flags=0x00, stream_id=0>
              (last_stream_id=0, error_code=NO_ERROR(0x00), opaque_data(0)=[])