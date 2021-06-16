#!/usr/bin/python

KMIN = 2500
KMAX = 5000

# 2021 11
angelegt = [
        14160,
        14036,
        14478,
        14824,
        14500,
        ]

frei = 14160 + 3029

cap = 120
preis = 118.9

# 2021 12
angelegt = [
        14036,
        14478,
        14824,
        14500,
        14040,
        ]

frei = 14160 + 2500

cap = 120
preis = 118.9

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

