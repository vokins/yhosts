python /Users/kwok/Desktop/updatehosts.py -s 8.8.8.8 -t a -c /Users/kwok/Desktop/hosts
grep '^#' /Users/kwok/Desktop/hosts.out > /Users/kwok/Desktop/NXDOMAIN
python /Users/kwok/Desktop/updatehosts.py -s 114.114.114.114 -t a -c /Users/kwok/Desktop/NXDOMAIN
grep '^#' /Users/kwok/Desktop/NXDOMAIN.out > /Users/kwok/Desktop/NXDOMAIN

