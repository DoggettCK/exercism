# Convert DNA->RNA and vice versa
class Complement
  DNA_CODE = 'GCTA'
  RNA_CODE = 'CGAU'

  def self.complement(code, from, to)
    # generate a regex ensuring entire string is only valid characters
    fail ArgumentError unless code =~ /^[#{from}]+$/

    # then just use built-in translation
    code.tr(from, to)
  end

  def self.of_dna(dna)
    complement(dna, DNA_CODE, RNA_CODE)
  end

  def self.of_rna(rna)
    complement(rna, RNA_CODE, DNA_CODE)
  end
end
