#!/usr/bin/python


from steuer import steuer, ags, kags

# Kirchensteuer bleibt unberücksichtigt bis auf Faktor 0.2451 statt 0.25

def individuell(sonst, kap):
    #
    # sonst: zu versteuerndes Einkommen ohne Kapitalerträge
    #        Altersentlastungsbetrag nicht abgezogen
    #        Kirchensteuer von Abgeltungssteuer nicht abgezogen
    # kap: Kapitalerträge, Sparer-Pauschbetrag schon abgezogen
    s = sonst - 1064 # Altersentlastungsbetrag
    s = s - 0.2451*0.08*kap
    print(s)
    print(steuer(s))
    s = s + kap
    print("indi", s)
    s1 = steuer(s)
    print(s1)
    return s1


def abgeltung(sonst, kap):
    #
    # sonst: zu versteuerndes Einkommen ohne Kapitalerträge
    #        Altersentlastungsbetrag nicht abgezogen
    #        Kirchensteuer von Abgeltungssteuer nicht abgezogen
    # kap: Kapitalerträge, Sparer-Pauschbetrag schon abgezogen
    s = sonst
    print(s)
    s1 = steuer(s)
    print("abg", s1)
    s2 = kap*0.2451
    print(s2, s1 + s2)
    s2 *= 1.055
    print(s2, s1 + s2)
    return s1 + s2


# sonst = 15307 + 1064 + 103 - 5364
sonst = 11385
individuell(sonst, 33383)
abgeltung(sonst, 33383)

