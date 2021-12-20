#!/bin/bash -

for i in $(awk '/texture.*192.168/{j=$0; sub(".*/","",j); print j;}' mcscript/*.mc | sort -u)
do
    [ "$i" = '.zip' ] && continue

    j=$(md5sum "texpack/texpack-$i"| awk '{print substr($1,1,8);}' )
    [ "$j" = '' ] && continue

    echo "s@\\(os map texture \\).*$i@\\\\1https://raw.githubusercontent.com/rdebath/mc/zip/$j.zip@"

done > tmp_pgm.sed

for i in mcscript/Block-cmd*.mc
do sed -i -f tmp_pgm.sed "$i"
done

