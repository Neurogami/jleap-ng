# Example JRuby LeapMotion program based on the Java example included in the Leap Motion SDK.
# 
$:.unshift './jleap-ng'
require 'jleap-ng'

include Neurogami::Leap

class ExampleListener < BasicListener 

  def onInit controller 
    puts "ExampleListener Initialized with #{controller.inspect}"
  end


  def onFrame controller
    frame = controller.frame

    puts  "Frame id: #{ frame.id}, timestamp: #{frame.timestamp}, hands: #{frame.hands.count}, fingers: #{frame.fingers.count} , tools: #{frame.tools.count}"

    if !frame.hands.empty?
      hand = frame.hands[0]
      fingers = hand.fingers
      if !fingers.empty?
        # Calculate the hand's average finger tip position
        avg_pos = Vector.zero

        fingers.each do |finger|
          avg_pos = avg_pos.plus finger.tipPosition 
        end

        avg_pos = avg_pos.divide fingers.count
        puts "Hand has #{fingers.count} fingers, average finger tip position: #{avg_pos}"
      end 

      # Get the hand's sphere radius and palm position
      # puts "Hand sphere radius: #{hand.sphereRadius } mm, palm position: #{ hand.palmPosition}"
      scaling = @previous_frame ? hand.scale_factor( @previous_frame ) : 1 

      if scaling != 1
        puts "Scaling: #{scaling}; hand sphere radius: #{hand.sphere_radius } mm, palm position: #{ hand.palm_position}"
      end

      normal = hand.palm_normal
      direction = hand.direction

      puts "Hand pitch: #{ Math.to_degrees direction.pitch } degrees, roll: #{ Math.to_degrees normal.roll } degrees, yaw: #{ Math.to_degrees direction.yaw } degrees\n"
    end 

    @previous_frame = frame 

  end 


end

class Example 

  def initialize 
    listener   = ExampleListener.new
    controller = Controller.new
    controller.add_listener listener

    warn "Press Enter to quit..."

    begin
      gets
    rescue 
      warn "Error! #{$!}"
    end

    controller.remove_listener listener

  end
end


s = Example.new


