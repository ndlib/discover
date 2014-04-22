class Permission
  attr_reader :user

  def initialize(user)
    @user = user
  end


  def is_admin?
    ['jhartzle', 'jkennel', 'rfox2', 'rmalott', 'lthiel'].include?(user.username)
  end

end
