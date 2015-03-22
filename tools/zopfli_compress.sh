#! /bin/bash
########################################################################
# written by George Liu (eva2000) vbtechsupport.com for h2o_installer.sh
# for CentminMod.com LEMP stack's Nginx vhost structure
# i.e. /home/nginx/domains/yourdomain.com/public
########################################################################
# specifically written for h2o HTTP/2 server to compressing static
# files html, css, js and xml when enabling h2o's file.send-gzip
# setting to serve out .gz files if detected.
# 
# this script uses Zopfli compression algorithm by default instead
# of gzip for better compression ratios https://github.com/google/zopfli
# edit ZOPFLIBIN to point to where you installed zopfli binary
# can also symlink to /usr/bin/h2o_compress for convenience
# e.g. ln -s /root/tools/zopfli_compress.sh /usr/bin/h2o_compress
# 
# can also use pigz multi-threaded compression tool's zopfli support
# if you have more than 1 cpu thread, pigz can use level 11 for zopfli
#   pigz -11k index.html
#   
# gzip uses level 4 by default if ZOPFLI or PIGZ are not available
########################################################################
DIRECTORIES="/home/nginx/domains/yourdomain.com/public"
MIN_SIZE=512

ZOPFLI='y'
ZOPFLILVL='-i30'
ZOPFLIBIN='/root/tools/zopfli/zopfli/zopfli'

# can only be used if you have more 
# than > 1 cpu thread for level 11
PIGZ='n'
PIGZLVL='-11'
PIGZBIN='/usr/bin/pigz'

GZIPLVL='-4'

FILETYPES=( "*.html" "*.css" "*.js" "*.xml" )
GZFILETYPES=( "*.html.gz" "*.css.gz" "*.js.gz" "*.xml.gz" )
DEBUG='y'
########################################################################
#
if [ -f /proc/user_beancounters ]; then
    CPUS=`cat "/proc/cpuinfo" | grep "processor"|wc -l`    
else
    # speed up make
    CPUS=`cat "/proc/cpuinfo" | grep "processor"|wc -l`    
fi

if [ ! -f "$ZOPFLIBIN" ]; then
  ZOPFLI='n'
fi

# if only 1 cpu thread and zopfli binary exists
if [[ "$CPUS" == '1' && "$ZOPFLIBIN" ]]; then
  PIGZ='n'
  ZOPFLI='y'
# if only 1 cpu thread and zopfli binary does not exists
elif [[ "$CPUS" == '1' && ! "$ZOPFLIBIN" ]]; then
  PIGZ='n'
  ZOPFLI='n'
# if pigz binary does not exist and pigz set to no
elif [[ ! -f "$PIGZBIN" && "$PIGZ" = [nN] ]]; then
  PIGZ='n'
# if pigz binary does not exist and pigz set to yes
elif [[ ! -f "$PIGZBIN" && "$PIGZ" = [yY] ]]; then
  PIGZ='n'
fi
##########################################################################
# function
compressnow() {
if [[ "$DEBUG" = [yY] ]]; then
 # displays all intended files that will be gzip compressed
 echo
 echo "-----------------------------------------------------------"
 echo "Listing static files that maybe compressed"
 echo "-----------------------------------------------------------"
 for currentdir in $DIRECTORIES
  do
    for i in "${FILETYPES[@]}"
    do
        find $currentdir -iname "$i" -print; \
    done
  done
  echo "-----------------------------------------------------------"
  echo
  # displays all intended files that will be gzip compressed
  echo
  echo "-----------------------------------------------------------"
  echo "Listing static files that are already gzip compressed"
  echo "-----------------------------------------------------------"
  for currentdir in $DIRECTORIES
   do
     for i in "${GZFILETYPES[@]}"
     do
         find $currentdir -iname "$i" -print; \
     done
   done
   echo "-----------------------------------------------------------"
   echo  
fi

# only gzip compress files greater than 1024 bytes in size in DIRECTORIES
# defined directory for html, css, js and xml
 
if [[ "$ZOPFLI" = [yY] ]]; then
    echo
  echo "-----------------------------------------------------------"
  echo "Zopfli compression starting"
  echo "-----------------------------------------------------------"
  for currentDir in $DIRECTORIES; do
    for f in "${FILETYPES[@]}"; do
      files="$(find $currentDir -iname "$f")";
      echo "$files" | while read file; do
        PLAINFILE=$file;
        GZIPPEDFILE=${file}.gz;
        # only run if PLAINFILE not empty
        if [[ ! -z "$PLAINFILE" ]]; then
          if [[ -e "$GZIPPEDFILE" ]]; then
            if [[ "$(stat --printf='%Y' "$PLAINFILE")" -gt "$(stat --printf='%Y' "$GZIPPEDFILE")" ]]; then
              echo ".gz is older, updating "$GZIPPEDFILE"…";
              rm -rf $GZIPPEDFILE
              echo "$ZOPFLIBIN $ZOPFLILVL -c "$PLAINFILE" > "$GZIPPEDFILE""
            else
              echo "$GZIPPEDFILE is newer, skip compression"
            $ZOPFLIBIN $ZOPFLILVL -c "$PLAINFILE" > "$GZIPPEDFILE";
            fi;
              if [[ "$(stat --printf='%s' "$PLAINFILE")" -le "$MIN_SIZE" ]]; then
              echo "Uncompressed size is less than minimum $(stat --printf='%s' "$PLAINFILE"), removing "$GZIPPEDFILE"";
            rm -f "$GZIPPEDFILE";
              fi;
          elif   [[ "$(stat --printf='%s' "$PLAINFILE")" -gt "$MIN_SIZE" ]]; then
              echo "Creating .gz "for" "$PLAINFILE"…";
              echo "$ZOPFLIBIN $ZOPFLILVL -c "$PLAINFILE" > "$GZIPPEDFILE""
              $ZOPFLIBIN $ZOPFLILVL -c "$PLAINFILE" > "$GZIPPEDFILE";
          fi;
        fi
      done
    done
  done
elif [[ "$PIGZ" = [yY] ]]; then
    echo
  echo "-----------------------------------------------------------"
  echo "pigz multi-threaded compression starting"
  echo "-----------------------------------------------------------"
  for currentDir in $DIRECTORIES; do
    for f in "${FILETYPES[@]}"; do
      files="$(find $currentDir -iname "$f")";
      echo "$files" | while read file; do
        PLAINFILE=$file;
        GZIPPEDFILE=${file}.gz;
        # only run if PLAINFILE not empty
        if [[ ! -z "$PLAINFILE" ]]; then
          if [[ -e "$GZIPPEDFILE" ]]; then
            if [[ "$(stat --printf='%Y' "$PLAINFILE")" -gt "$(stat --printf='%Y' "$GZIPPEDFILE")" ]]; then
              echo ".gz is older, updating "$GZIPPEDFILE"…";
              echo "pigz $PIGZLVL -f -c "$PLAINFILE" > "$GZIPPEDFILE""
              pigz $PIGZLVL -f -c "$PLAINFILE" > "$GZIPPEDFILE";
            else
              echo "$GZIPPEDFILE is newer, skip compression"
            fi;
            if [[ "$(stat --printf='%s' "$PLAINFILE")" -le "$MIN_SIZE" ]]; then
              echo "Uncompressed size is less than minimum $(stat --printf='%s' "$PLAINFILE"), removing "$GZIPPEDFILE"";
              rm -f "$GZIPPEDFILE";
            fi;
            elif [[ "$(stat --printf='%s' "$PLAINFILE")" -gt "$MIN_SIZE" ]]; then
              echo "Creating .gz "for" "$PLAINFILE"…";
              echo "pigz $PIGZLVL -c "$PLAINFILE" > "$GZIPPEDFILE";"
              pigz $PIGZLVL -c "$PLAINFILE" > "$GZIPPEDFILE";
            fi;
        fi
      done
    done
  done
else
    echo
  echo "-----------------------------------------------------------"
  echo "gzip compression starting"
  echo "-----------------------------------------------------------"
  for currentDir in $DIRECTORIES; do
    for f in "${FILETYPES[@]}"; do
      files="$(find $currentDir -iname "$f")";
      echo "$files" | while read file; do
        PLAINFILE=$file;
        GZIPPEDFILE=${file}.gz;
        # only run if PLAINFILE not empty
        if [[ ! -z "$PLAINFILE" ]]; then
          if [[ -e "$GZIPPEDFILE" ]]; then
            if [[ "$(stat --printf='%Y' "$PLAINFILE")" -gt "$(stat --printf='%Y' "$GZIPPEDFILE")" ]]; then
              echo ".gz is older, updating "$GZIPPEDFILE"…";
              echo "gzip $GZIPLVL -f -c "$PLAINFILE" > "$GZIPPEDFILE";"
              gzip $GZIPLVL -f -c "$PLAINFILE" > "$GZIPPEDFILE";
            else
              echo "$GZIPPEDFILE is newer, skip compression"
            fi;
            if [[ "$(stat --printf='%s' "$PLAINFILE")" -le "$MIN_SIZE" ]]; then
              echo "Uncompressed size is less than minimum $(stat --printf='%s' "$PLAINFILE"), removing "$GZIPPEDFILE"";
              rm -f "$GZIPPEDFILE";
            fi;
            elif [[ "$(stat --printf='%s' "$PLAINFILE")" -gt "$MIN_SIZE" ]]; then
              echo "Creating .gz "for" "$PLAINFILE"…";
              echo "gzip $GZIPLVL -c "$PLAINFILE" > "$GZIPPEDFILE""
              gzip $GZIPLVL -c "$PLAINFILE" > "$GZIPPEDFILE";
            fi;
        fi
      done
    done
  done
fi # ZOPFLI
}

###############
compressnow

exit