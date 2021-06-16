#!/usr/bin/python

KMIN = 2500
KMAX = 5000

angelegt = [
        14160,
        14036,
        14478,
        14824,
        14500,
        ]

frei = 14160 + 3029
# frei = 14160 + 1029

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

