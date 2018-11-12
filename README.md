# pompem-docker
Pompem docker container

# Running the container

Set the POMPEM_SEARCH variable to the package you want to find vulnerabilities for

docker run -e "POMPEM_SEARCH=ssh" --rm martinhell/pompem
