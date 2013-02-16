require "java"

$:.unshift "#{ENV['LEAP_SDK_HOME']}/lib/"

require 'LeapJava.jar'

import java.io.IOException
import java.lang.Math

module LeapMotion
  include_package 'com.leapmotion.leap'
end

include LeapMotion

module Neurogami
  module Leap

    class BasicListener < LeapMotion::Listener 

      alias_method :on_frame , :onFrame  
      alias_method :on_init , :onInit

      #  onInit — dispatched once, when the controller to which the listener 
      #  is registered is initialized.
      def onInit controller 
        puts "#{self.inspect} Initialized with #{controller.inspect}"
      end

      # onConnect — dispatched when the controller connects to the Leap and is 
      # ready to begin sending frames of motion tracking data.
      def onConnect controller
        puts "Connected"
      end 

      # onDisconnect — dispatched if the controller disconnects from the Leap (for example, 
      # if you unplug the Leap device or shut down the Leap software).
      def  onDisconnect controller
        puts "Disconnected"
      end


      # onExit — dispatched to a listener when it is removed from a controller.
      def onExit controller
        puts "Exited!"
      end


      #def onFrame controller
      #  raise "You really need to override the onFrame method!"
      #end

    end

    class Controller < LeapMotion::Controller
    
    end


    class Vector < LeapMotion::Vector

    end

    class Java::ComLeapmotionLeap::Hand

    end

    class Java::ComLeapmotionLeap::Frame
      alias_method :leap_hands, :hands
      def hands
        leap_hands.to_a
      end

    end
    
  end 
end


