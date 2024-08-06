#!/usr/bin/python


# veraltet
#
from steuer import steuer, ags, kags

sonst = 11386  # 2023
sonst = 11900  # 2024

kap = 10000
fak = 1.08
fak = 1.0
s = round(steuer(sonst)*fak)

while kap <= 40000:

    ohnekap = round(s + ags(kap))
    mitkap = round(steuer(sonst - kags(kap) - 1064 + kap)*fak)
    print(kap, ohnekap, mitkap, mitkap - ohnekap)
    kap += 2000
