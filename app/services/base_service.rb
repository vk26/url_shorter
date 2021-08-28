require 'dry/monads'
require 'dry/schema'

class BaseService
  extend Dry::Initializer
  include Dry::Monads[:result]
  
  def self.call(**args)
    validation = self::Schema.call(args)
    return Failure.new(validation.errors.to_h) unless validation.success?
    
    new(**args).call
  rescue StandardError => error
    handle_error(error)  
  end

  def self.handle_error(error)
    Failure.new(error)
  end
end
