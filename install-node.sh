#!/bin/bash

maysudo=""

if [ "$is_root" = "false" ]
   then
      maysudo="sudo"
   else
      maysudo=""
fi

echo "sudo? $maysudo"

exit
