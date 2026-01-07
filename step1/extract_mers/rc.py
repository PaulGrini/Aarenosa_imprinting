'''reverse complement streaming text'''
import sys
NOPALINDROMES=True
D = {'A':'T', 'T':'A', 'C':'G', 'G':'C'}
for line in sys.stdin:
    line = line.rstrip()
    revstr = line[::-1]
    revcmp = ''
    for c in revstr:
        revcmp=revcmp+D[c]
    if NOPALINDROMES and revcmp==line:
        continue
    print(revcmp)
