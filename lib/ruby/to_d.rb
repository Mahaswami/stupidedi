require "bigdecimal"
require "rational"

class BigDecimal

  # @return [BigDecimal] self
  def to_d
    self
  end
end

class String
  BIGDECIMAL = /\A[+-]?            (?# optional leading sign            )
                (?:
                  (?:\d+\.?\d*)  | (?# whole with optional decimal or ..)
                  (?:\d*?\.?\d+) ) (?# optional whole with decimal      )
                (?:E[+-]?\d+)?     (?# optional exponent                )
               \Z/ix

  # Converts the string to a BigDecimal after validating the format. If the
  # string does not match the pattern for a valid number, an `ArgumentError`
  # is raised.
  #
  # @example
  #   "1.0".to_d  #=> BigDecimal("1.0")
  #
  # @return [BigDecimal]
  def to_d
    if BIGDECIMAL =~ self
      BigDecimal(to_s)
    else
      raise ArgumentError, "#{inspect} is not a valid number"
    end
  end
end

class Integer

  # Converts the integer to a BigDecimal
  #
  # @example
  #   10.to_d   #=> BigDecimal("10")
  #
  # @return [BigDecimal]
  def to_d
    BigDecimal(to_s)
  end
end

class Rational

  # Converts the rational to a BigDecimal
  #
  # @example
  #   Rational(3, 4).to_d   #=> BigDecimal("3") / BigDecimal("4")
  #
  # @return [BigDecimal]
  def to_d
    numerator.to_d / denominator.to_d
  end
end

