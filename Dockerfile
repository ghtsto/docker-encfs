FROM alpine:latest
LABEL maintainer="ghtsto"

RUN \
 apk update && apk add bash encfs fuse expect

RUN echo -e '#!/bin/bash\n\
DIR1=$(mktemp -d)\n\
DIR2=$(mktemp -d)\n\
EXPECT=$(cat <<END\n\
set timeout -1\n\
spawn encfs $DIR1 $DIR2\n\
match_max 100000\n\
expect "select standard mode.\\r"\n\
send -- "\\r"\n\
expect "New Encfs Password: "\n\
send -- "$ENCFS_PASS\\r"\n\
expect "Verify Encfs Password: "\n\
send -- "$ENCFS_PASS\\r"\n\
expect eof\n\
END\n\
)\n\
expect -c "${EXPECT//\n\
/;}"\n\
cp -a $DIR1/.encfs6.xml /encfs/encfs.xml\n\
echo "$ENCFS_PASS" > /encfs/encfspass\n\
chown -R 1000:1000 /encfs'\
>> /usr/bin/generate-encfs && \
chmod +x /usr/bin/generate-encfs
