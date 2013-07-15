RSpec::Matchers.define :response_with_status_code do |expected_code|
  match do |actual|
    actual[:status_code] == expected_code.to_s
  end

  failure_message_for_should do |actual|
    "expected responsed status Code: '#{actual[:status_code]}' to be: '#{expected_code}' #{actual[:status_message]} #{actual[:raw]}"
  end

  failure_message_for_should_not do |actual|
    "expected Status Code not to match #{expected_code}"
  end

  description do
    "response with status code '#{expected_code}'"
  end

end


RSpec::Matchers.define :response_with_object do |expected_object|
  match do |response|
    response[:object] == expected_object
  end

  failure_message_for_should do |response|
    "expected responsed with Object: '#{response[:object]}' to be: '#{expected_object}'"
  end

  failure_message_for_should_not do |response|
    "expected Status Code not to match #{expected_object}"
  end

  description do
    "response with object'#{expected_object}'"
  end

end

RSpec::Matchers.define :respond_object_with do |attribute|
  match do |response|
    object = response[:object]
    if object.key? attribute
      if @value.nil?
        if @not_nil.nil?
          true
        else
          not object[attribute].nil?
        end
      else
        object[attribute] == @value
      end
    else
      false
    end
  end

  chain :and_value do |value|
    @value = value
  end

  chain :not_nil do
    @not_nil = true
  end

  failure_message_for_should do |response|
    object = response[:object]
    if object.key? attribute
      "expected value of responded object to be '#{@value}' instead of actual '#{object[attribute]}'"
    else
      "expected responded object: #{response[:object]} to have attribute: #{attribute}"
    end
  end

  failure_message_for_should_not do |response|
    object = response[:object]
    if @value.nil?
      "expected responded object not including attribute: '#{attribute}'"
    else
      "expected responded attribute '#{attribute}' of object not to be '#{@value}'"
    end
  end

  description do
    message = "responde object with attribute '#{attribute}'"
    message << " not nil" unless @not_nil.nil?
    message << " and value '#{@value}'" unless @value.nil?
    message
  end

end
