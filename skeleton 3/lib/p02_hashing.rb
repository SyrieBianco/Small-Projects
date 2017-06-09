class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    each_with_index.inject(0) do |intermediate_hash, (el, i)|
      (el.hash + i.hash) ^ intermediate_hash
    end
  end


  # def hash
  #   result = ""
  #   self.each_with_index do |el, i|
  #     el.is_a?(Integer) ? result << el.abs.to_s : result << el.to_s
  #     i.is_a?(Integer) ? result << i.abs.to_s : result << i.to_s
  #   end
  #   result.to_i.hash
  # end
end

class String
  def hash
    l_case = ("a".."z").to_a
    u_case = ("A".."Z").to_a
    digits = ("0".."9").to_a
    alphabet = l_case + u_case + digits



    arr = chars.map do |ch|
      ch = alphabet.index(ch)
    end
    arr
    arr.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    alphabet = ("a".."z").to_a

    hsh = self
    hsh.map { |k, v| k, v = k.to_s, v.to_s }

    arr = hsh.sort_by { |el| el[0] } .flatten

    arr.map do |str|
      str = str.hash
    end

    arr.hash
  end
end
