class HoldsRequest
  include Virtus.model

  include ActiveModel::Validations

  attribute :volume, String
  attribute :library, String
  attribute :pickup_location, String
  attribute :cancel_date, String

  validates :volume, :library, :pickup_location, presence: true

  def initialize(data)
    self.attributes = data
  end

  def save_params(params)
    self.attributes = params
  end


  def params
    self.attributes
  end


  def complete?
    valid?
  end


end
