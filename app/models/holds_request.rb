class HoldsRequest
  include Virtus.model

  include ActiveModel::Validations

  attribute :request_id, String
  attribute :pickup_location, String
  attribute :cancel_date, String

  validates :request_id, :pickup_location, presence: true

  def initialize(data)
    self.attributes = data
  end

  def save_params(params)
    self.attributes = params
  end

  def decrypted_item_id
    HoldItem.decrypt_item_id(request_id)
  end

  def params
    self.attributes
  end

  def complete?
    valid?
  end


end
