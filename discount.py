#!/usr/bin/python

KMIN = 2800
KMAX = 5000

# 2022 03
angelegt = [
        14824,
        14500,
        108*125,
        108*125,
        111*125 + 50*124,
        ]

frei = 12000

cap = 124
preis = 122.47

# print('My first python script')

s = sum(angelegt)

print('angelegt', s)
print('frei', frei)

la = len(angelegt)
assert la == 5, "angelegt falsche länge"
ziel = round((frei + s - KMAX)/(la + 1))
#  ziel -= 6200
stueck = round(ziel/cap)
print('Ziel', ziel)
print('Stueck', stueck)

gesamt = stueck*preis
rest = frei - gesamt

print('Gesamt', gesamt)
print('Rest', rest)

while rest > KMAX :
    stueck += 1
    rest -= preis

while rest < KMIN :
    stueck -= 1
    rest += preis

print('Stueck', stueck)
print('Rest', rest)
print('Neu angelegt', stueck*cap)

