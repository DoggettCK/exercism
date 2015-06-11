RubyVM::InstructionSequence.compile_option = {
  tailcall_optimization: true,
  trace_instruction: false
}

# Prime number factorization
class PrimeFactors
  def self.for(n, acc = [])
    if n < 2
      acc
    else
      factor = (2..Math.sqrt(n).ceil).find { |x| n % x == 0 }

      if factor.nil?
        acc << n
      else
        PrimeFactors.for(n / factor, acc << factor)
      end
    end
  end
end
