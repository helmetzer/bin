#   module steuer

# 2023
grund = 10908
next = 15999
next2 = 62809
next3 = 277825
f1 = 979.18
f2 = 192.59
s1 = 966.53
s2 = 9972.98
s3 = 18307.73

# 2024
grund = 11604
next = 17005
next2 = 66760
next3 = 277825
f1 = 922.98
f2 = 181.9
s1 = 1025.38
s2 = 10602.13
s3 = 18936.88

ag = 0.2451

def ags(von):

    return 1.135*ag*von

def kags(von):

    return 0.08*ag*von

def steuer(von):

    if von <= grund:
        return 0

    if von <= next:
        y = (von - grund)/10000
        return (f1*y + 1400)*y

    if von <= next2:
        y = (von - next)/10000
        return (f2*y + 2397)*y + s1

    if von <= next3:
        return 0.42*von - s2

    return 0.45*von - s3
