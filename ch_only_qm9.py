# extract structures without oxygen 
from ase.io import read, write
import numpy as np

atoms=read('file.xyz', index=':')

for i in range(0,50570):
	tmp=atoms[i].numbers
	tmp2=np.count_nonzero(tmp == 8)
	if ( tmp2 < 1 ):
		write("qm9_ch_only_mod.xyz", atoms[i], append=True)
	else:
		continue
