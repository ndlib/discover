class PrimoDisplayFieldDecorator < Draper::Decorator
  delegate :key, :record_id, to: :object

  def last_miss_date
    object.examples.order(:created_at).first.created_at.to_s(:long_ordinal)
  end


  def number_of_misses
    object.examples.size
  end


  def recent_misses
    object.examples.order(:created_at).limit(4)
  end
end
