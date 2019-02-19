# DNS CA Tools

These tools will help you to determine the issuer of the certificate of your domain(s)

# do_check_ca.sh [domain] [port]

To check a single domain
Port is optional; defaults to 443

# check_cas.sh [input file]

Wrapper script that enables you to check multiple domains in batch. All domains should be put in a separate file (separated by newlines) that can then be passed as an argument to this script

# Usage

## Suppress all output except successful results

    ./do_check_ca.sh www.domain.com | grep ","
    ./check_cas.sh list.txt | grep ","

## Suppress all output except successful results and hide domain name

    ./do_check_ca.sh www.domain.com | grep "," | awk -F ',' '{print $2}'
    ./check_cas.sh list.txt | grep "," | awk -F ',' '{print $2}'

