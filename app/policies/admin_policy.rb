class AdminPolicy < Struct.new(:user, :admin)
  def initialize(user, record)
    raise Pundit::NotAuthorizedError, "must be logged in" unless user
    @user = user
    @record = record
  end

  def index?
    authorize @user, :admin
    true
  end

  def ext?
    authorize @user, :admin
    true
  end

  def direct?
    authorize @user, :admin
    true
  end

  def dispatcher?
    authorize @user, :admin
    true
  end
end
