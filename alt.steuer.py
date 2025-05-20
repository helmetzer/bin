#!/usr/bin/python3


# veraltet
#
from steuer import steuer, ags, kags

sonst = 10435

kap = 10000
fak = 1.0
fak = 1.08
s = round(steuer(sonst)*fak)

while kap <= 50000:

    ohnekap = round(s + ags(kap))
    mitkap = round(steuer(sonst - kags(kap) - 1064 + kap)*fak)
    print(kap, ohnekap, mitkap, mitkap - ohnekap)
    kap += 2000
