class StatsSource < ActiveRecord::Base

  def self.get_source(primo_id, source)
    self.where(primo_id: primo_id).first || self.create(primo_id: primo_id, source: source)
  end

end
