class HoldsRequest
  attr_reader :controller, :record

  def initialize(controller, record)
    @controller = controller
    @record = record
  end


  def add_step1(data)
    session_save(:volume, data[:volume])
  end


  def add_step2(data)
    session_save(:library, data[:library])
  end


  def add_step3(data)
    session_save(:pickup_location, data[:pickup_location])
  end


  def add_step4(data)
    session_save(:cancel_date, data[:cancel_date])
  end


  def request_params
    controller.session[holds_key]
  end


  private

    def session_save(key, value)
      controller.session[holds_key] ||= {}
      controller.session[holds_key][key] = value
    end


    def holds_key
      "#{record.id}-#{controller.params[:username]}"
    end

end
