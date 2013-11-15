class VineError < StandardError
  def initialize(json)
    message = "Vine API error[#{json[:code]}] - #{json[:error]}"
    super(message)
  end
end
