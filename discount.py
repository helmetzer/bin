#!/usr/bin/python

KMIN = 2800
KMAX = 5000

# 2022 02
angelegt = [
        14036,
        14478,
        14824,
        14500,
        108*125
        ]

frei = 19554 - 2500 - 800

cap = 125
preis = 123.58

# print('My first python script')

s = sum(angelegt)

print('angelegt', s)
print('frei', frei)

ziel = round((frei + s - KMAX)/(len(angelegt) + 1))
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

