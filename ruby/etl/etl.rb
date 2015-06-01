# Extract, Transform, and Load
class ETL
  def self.transform(old)
    new = Hash.new { |h, k| h[k] = [] }

    old.each do |k, v|
      v.each do |nk|
        new[nk.downcase] = k
      end
    end

    new
  end
end
