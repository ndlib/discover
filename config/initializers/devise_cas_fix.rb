module Devise
  module Models
    module CasAuthenticatable
      module ClassMethods
        alias_method :original_authenticate_with_cas_ticket, :authenticate_with_cas_ticket
        def authenticate_with_cas_ticket(ticket)
          begin
            original_authenticate_with_cas_ticket(ticket)
          rescue ActiveRecord::RecordNotUnique
            original_authenticate_with_cas_ticket(ticket)
          end
        end
      end
    end
  end
end
