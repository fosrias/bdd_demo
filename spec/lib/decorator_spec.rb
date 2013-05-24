require 'spec_helper'

describe Decorator do
  let(:simple_test_class) do
    Class.new { include Decorator }
  end
  let (:test_instance) {simple_test_class.new}
  let (:test_instance2) {Class.new.new }

  describe '.my_message' do
    it 'sets a special message for the class' do
      simple_test_class.my_message = 'improved message'
      simple_test_class.my_message.should == 'improved message'
    end
  end
  
  describe '#to_s' do  
    context 'with no method set' do
      it 'raises an error if no message is set on the class' do
        test_instance = simple_test_class.new
        expect { test_instance.to_s }.to raise_error
      end
    end
    
    context 'with message set' do
      it 'returns the original to_s with an added message' do
        simple_test_class.my_message = 'improved'
        test_instance.to_s.should =~ /.*improved$/
      end
    end

    # Note, these specs are not yet correct. Homework is to get them to pass and be confident it is testing the 
    # CORRECT thing.
    context 'with runtime decoration' do
      it 'does not pollute the base class' do
        # test_instance2.singleton_class.send(:include, Decorator)
        test_instance2.extend(Decorator) # same effect as above, but cleaner
        test_instance2.class.should_not respond_to(:my_message)
      end
      
      it 'returns a message decorated string' do
        test_instance2.singleton_class.send(:include, Decorator)
        test_instance2.my_message = 'improved'
        test_instance2.to_s.should =~ /.*improved$/
      end
    end
  end
  
  describe '#inspect' do
    it 'does not include a message' do
      simple_test_class.my_message = 'improved'
      test_instance.inspect.should_not =~ /.*improved$/
    end
  end
end
