#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
echo $SCRIPT_DIR

export MIBEW_VERSION=3.5.7
export MIBEW_SHA1=b511aed34e22ed97752e0185997cee79daacd4f7
export MIBEW_DE_SHA1=5f9c6053560b72a3f06d626a6bd83af9a2cce37e

tmpdir=$(mktemp -d)
echo $tmpdir
cd $tmpdir
curl -o mibew.tar.gz -fSL "https://downloads.sourceforge.net/project/mibew/core/${MIBEW_VERSION}/mibew-${MIBEW_VERSION}.tar.gz" && \
	ls $tmpdir && \
  # check if file exists, just to be safe
  test -f "mibew.tar.gz" && \
  # check sha1 sum
  echo "$MIBEW_SHA1 *mibew.tar.gz" | sha1sum -c -&& \
  # Extract files to apache root folder
  #tar -xzf mibew.tar.gz --strip 1 -C /var/www/html/ && \
  tar -xzf mibew.tar.gz -C $tmpdir && \
  # download locales de
  curl -o mibew-i18n-de.tar.gz -fSL "https://sourceforge.net/projects/mibew/files/i18n/de/${MIBEW_VERSION}/mibew-i18n-de-${MIBEW_VERSION}-20211214.tar.gz" && \
  tar -xzf mibew-i18n-de.tar.gz -C $tmpdir/mibew/locales/

# retrieve / copy mibew config dirs as seed for volumes
mkdir -p $SCRIPT_DIR/mibew-config
cp -r mibew/styles mibew/sounds mibew/plugins mibew/locales $SCRIPT_DIR/mibew-config

cd $SCRIPT_DIR
rm -r $tmpdir

docker-compose build
docker-compose up
