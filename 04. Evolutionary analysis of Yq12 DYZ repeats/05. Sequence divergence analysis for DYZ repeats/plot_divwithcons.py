import pandas as pd
import matplotlib.pyplot as plt


plt.rcParams['pdf.fonttype'] = 42
df_dyz1 = pd.read_csv('C001-CHA-E01.DYZ1div', sep='\t', header=None, names=['start', 'end', 'div'])
df_dyz2 = pd.read_csv('C001-CHA-E01.DYZ2div', sep='\t', header=None, names=['start', 'end', 'div'])
df_dyz1['start']=df_dyz1['start']/1000000
df_dyz1['end']=df_dyz1['end']/1000000
df_dyz2['start']=df_dyz2['start']/1000000
df_dyz2['end']=df_dyz2['end']/1000000

df_dyz1['center'] = (df_dyz1['start'] + df_dyz1['end']) / 2
df_dyz2['center'] = (df_dyz2['start'] + df_dyz2['end']) / 2


plt.figure(figsize=(12, 2))


plt.bar(df_dyz1['center'], df_dyz1['div'], width=df_dyz1['end'] - df_dyz1['start'], color='#d17d4a', label='DYZ1')


plt.bar(df_dyz2['center'], df_dyz2['div'], width=df_dyz2['end'] - df_dyz2['start'], color='#3F66A1', label='DYZ2')


plt.legend()
plt.xlabel('Position(Mb)')
plt.ylabel('Divergence')
plt.title('C001-CHA-E01')


plt.tight_layout()
plt.savefig("C001-CHA-E01.div.pdf")
plt.close()
