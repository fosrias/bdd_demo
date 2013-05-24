require 'active_support/concern'

module Decorator
  extend ActiveSupport::Concern
  
  # Better way.
  module ClassMethods
    attr_accessor :my_message
  end

  #module ClassMethods
  #  def my_message=(value)
  #    @my_message = value
  #  end
  #
  #  def my_message
  #    @my_message
  #  end
  #end
  
  alias :old_to_s :to_s
  def to_s
    raise 'No message set' unless self.class.my_message
    old_to_s + 'improved'
  end
  
  def inspect
    old_to_s # This is not entirely correct because inspect does more than to_s, but did not get that far in the demo.
  end
end
