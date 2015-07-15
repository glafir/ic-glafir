class ApplicationPolicy < Struct.new(:user, :record)
  attr_reader :user, :record

  def initialize(user, record)
    raise Pundit::NotAuthorizedError, "must be logged in" unless user
    @user = user
    @record = record
  end

  def readers
    @user.admin? or @user.user? or @user.vip?
  end

  def writers
    @user.admin? or @user.vip?
  end

  def index?
    readers
  end

  def show?
    scope.where(:id => record.id).exists?
    readers
  end

  def create?
    writers
  end

  def new?
    writers
  end

  def update?
    writers
  end

  def edit?
    writers
  end

  def destroy?
    writers
  end

  def scope
    Pundit.policy_scope!(user, record.class)
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope
    end
  end
end
