# Extract, Transform, and Load
class ETL
  def self.transform(old)
    old.flat_map { |k, v| v.map { |x| [x.downcase, k] } }.to_h
  end
end
