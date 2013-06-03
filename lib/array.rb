class Array
  def to_s
    "[" + map(&:to_s).join(', ') + "]"
  end
end
