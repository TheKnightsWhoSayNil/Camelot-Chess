class Ball
 attr_reader :ball_type
  
  def initialize(ball_type = "regular")
   @ball_type = ball_type
  end
end