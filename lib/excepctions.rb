module Exceptions
  class PresenciaValoresExcepcion < StandardError;
    def initialize(errors)
      @errors = errors
    end
    
    attr_accessor :errors
  end
end
