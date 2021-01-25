#!/usr/bin/env bash

source $(dirname "$0")/functions.sh

createSymLinks

set -eu

script_dir="$(cd -- "$(dirname "$0")" && pwd)"
root_dir="$script_dir"/../..

set -x

rm -rf -- "$root_dir"/vendor/mpdf/mpdf/ttfonts
rm -rf -- "$root_dir"/vendor/google/protobuf/src
rm -rf -- "$root_dir"/vendor/google/protobuf/java
rm -rf -- "$root_dir"/vendor/google/protobuf/objectivecs
rm -rf -- "$root_dir"/vendor/google/protobuf/csharp
rm -rf -- "$root_dir"/vendor/google/protobuf/python
rm -rf -- "$root_dir"/vendor/google/protobuf/ruby
rm -rf -- "$root_dir"/vendor/google/protobuf/js
rm -rf -- "$root_dir"/vendor/google/protobuf/javanano
rm -rf -- "$root_dir"/vendor/google/protobuf/php/ext
rm -rf -- "$root_dir"/vendor/google/protobuf/php/tests
rm -rf -- "$root_dir"/vendor/google/cloud/tests
rm -rf -- "$root_dir"/vendor/google/cloud/dev
rm -rf -- "$root_dir"/vendor/google/cloud/docs

echo -e "DONE" >> "${__FIRST_INSTALL_DONE}"

set +eux