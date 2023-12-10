#!/bin/bash

test="yes"

if [ "$test" == "yes" ]; then
: #no-op cmd, thanks to https://stackoverflow.com/a/17583599
else
  echo "not a test"
fi

echo "don't stop, continue!"
