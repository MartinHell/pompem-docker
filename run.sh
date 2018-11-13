#/bin/bash

cd /root/pompem/

python pompem.py -s ${POMPEM_SEARCH:-gitlab} --txt

IFS=$'\n'

sed -i '/date;description;url/d' out.txt

for i in $(cat out.txt); do 
	DATE=$(echo $i | cut -d ';' -f1)
	DATE_CONVERTED=$(date -d "${DATE}" +%s)
	echo $i | sed "s/^${DATE};/${DATE_CONVERTED};/" >> converted.txt
done

if [ -z ${BEGIN_DATE} ]; then
	BEGIN_DATE=$(date -d "$(date +%Y-%m-%d -d 'yesterday')" +%s)
else
	BEGIN_DATE=$(date -d "${BEGIN_DATE}" +%s)
fi

if [ -z ${END_DATE} ]; then
	END_DATE=$(date +%s)
else
	END_DATE=$(date -d "${END_DATE}" +%s)
fi

cat converted.txt | awk -v B_DATE=$BEGIN_DATE -v E_DATE=$END_DATE '$1 >=B_DATE && $1 <=E_DATE'

