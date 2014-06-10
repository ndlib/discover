class Permission
  attr_reader :user

  def initialize(user)
    @user = user
  end


  def is_admin?
    Rails.env.development? || ['jhartzle', 'jkennel', 'rfox2', 'rmalott', 'lthiel', 'hanstra', 'msuhovec', 'abales', 'lajamie', 'awetheri'].include?(user.username)
  end

end
