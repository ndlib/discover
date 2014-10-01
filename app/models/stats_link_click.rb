class StatsLinkClick < ActiveRecord::Base
  belongs_to :stats_source

  def self.record_click(primo_id, source, title)
    source = StatsSource.get_source(primo_id, source)
    self.create(fulltext_title: title, stats_source: source)
  end
end
