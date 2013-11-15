class VineHasher
  VINE_KEY = 'BuzaW7ZmKAqbhMOei5J1nvr6gXHwdpDjITtFUPxQ20E9VY3Ll'
  VINE_KEY_SIZE = VINE_KEY.size
  VINE_KEY_HASH = VINE_KEY.split('').each_with_index.inject({}) {|hash, (key, index)| hash[key] = index; hash }
 
  def self.unhash_id(hashed_id)
    hashed_id = hashed_id.to_s
    if unhashable?(hashed_id)
      hashed_id.reverse.split('').each_with_index.inject(0) { |total, (key, index)| total + VINE_KEY_HASH[key] * VINE_KEY_SIZE**index }
    end
  end
 
  def self.hash_id(id)
    id.to_base(VINE_KEY_SIZE).map{|n| VINE_KEY[n]}.join()
  end

  def self.unhashable?(id)
    !(id =~ /^[#{VINE_KEY}]+$/).nil?
  end

  class ::Integer
    def to_base(base=10)
      return [0] if zero?
      raise ArgumentError, 'base must be greater than zero' unless base > 0
      num = abs
      return [1] * num if base == 1
      [].tap do |digits|
        while num > 0
          digits.unshift num % base
          num /= base
        end
      end
    end
  end
end
