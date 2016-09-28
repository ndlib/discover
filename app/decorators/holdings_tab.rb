class HoldingsTab < PrimoRecordTab
  def record_links
    @record_links ||= RecordLinks.new(record)
  end

  def institution_holdings(code)
    record.holdings[code.downcase]
  end

  def primary_instituction_code
    @primary_instituction_code ||= vid.downcase
  end

  def other_institution_codes
    ['ndu', 'smc', 'hcc', 'bci', 'ndlaw'].reject{ | code | code == primary_instituction_code }
  end

  private

  def load_record
    DiscoveryQuery.holdings(id, vid)
  end
end
