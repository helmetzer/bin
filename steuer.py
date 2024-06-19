#   module steuer

jahr = 2024
# 2023
if jahr == 2023:
    grund = 10908
    next = 15999
    next2 = 62809
    next3 = 277825
    f1 = 979.18
    f2 = 192.59
    s1 = 966.53
    s2 = 9972.98
    s3 = 18307.73
else:

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
k1 = 0.08
k2 = 1 + k1
soli = 0.055
solik = 1.0 + soli + k1


def ags(von):

    return solik*ag*von

def kags(von):

    return k1*ag*von

def steuer(von):

    if von <= grund:
        st = 0

    elif von <= next:
        y = (von - grund)/10000
        st = (f1*y + 1400)*y

    elif von <= next2:
        y = (von - next)/10000
        st = (f2*y + 2397)*y + s1

    elif von <= next3:
        st = 0.42*von - s2

    else:
        st = 0.45*von - s3

    return st*k2
