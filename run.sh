#/bin/bash

cd /root/pompem/

python pompem.py -s ${POMPEM_SEARCH:-gitlab} --txt > /dev/null

IFS=$'\n'

sed -i '/date;description;url/d' out.txt

END=${END_DATE:-$(date +%Y-%m-%d)}
START=${BEGIN_DATE:-$(date +%Y-%m-%d -d 'yesterday')}

awk -v B_DATE=${START} -v E_DATE=${END} '$1 >=B_DATE && $1 <=E_DATE {print $0"\n"}' out.txt
