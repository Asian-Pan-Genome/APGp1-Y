import sys
import pysam

if len(sys.argv) != 4:
    print(f'Usage: python {sys.argv[0]} input.vcf(.gz) allele_length out_prefix')
    print(f'Please `bcftools index input.vcf(.gz)` in advance')
    print('This script will output three files: SNPs, MNPs, INDELs (small variants) and SVs based on the inputted length')
    sys.exit(1)


if sys.argv[1].endswith('.vcf'):
    f = pysam.VariantFile(sys.argv[1], 'r')
    suffix = '.vcf'
elif sys.argv[1].endswith('.vcf.gz'):
    f = pysam.VariantFile(sys.argv[1], 'rb')
    suffix = '.vcf.gz'
allele_length = int(sys.argv[2])
f_snp_out = pysam.VariantFile(f'{sys.argv[-1]}.SNPs{suffix}', 'w', header=f.header)
f_mnp_out = pysam.VariantFile(f'{sys.argv[-1]}.MNPs{suffix}', 'w', header=f.header)
f_indel_out = pysam.VariantFile(f'{sys.argv[-1]}.INDELs{suffix}', 'w', header=f.header)
f_sv_out = pysam.VariantFile(f'{sys.argv[-1]}.SVs{suffix}', 'w', header=f.header)

for rec in f.fetch():
    uniq_lengths = set([len(i) for i in rec.alleles])
    if max(uniq_lengths) < allele_length:
        if len(uniq_lengths) > 1:
            f_indel_out.write(rec)
        else:
            if list(uniq_lengths)[0] > 1:
                f_mnp_out.write(rec)
            else:
                f_snp_out.write(rec)
    else:
        f_sv_out.write(rec)

f.close()
f_snp_out.close()
f_mnp_out.close()
f_indel_out.close()
f_sv_out.close()
