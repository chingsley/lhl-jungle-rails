class Sale < ActiveRecord::Base

  # has_many :products

  validates :name, presence: true
  validates :starts_on, presence: true
  validates :ends_on, presence: true
  validates :percent_off, presence: true


  # self. is how we we create a class/static method in ruby
  # this is called Active Record Scope (AR scope)
  def self.active
    self.where("sales.starts_on <= ? AND sales.ends_on >= ?", Date.current, Date.current) # also works without the self. ie. where("...") will also work
  end

  # another method to create scope:
  # scope :active, -> { Sale.where("sales.starts_on <= ? AND sales.ends_on >= ?", Date.current, Date.current) }
  ## and we can call this using Sale.active, we can attach other methods to the resutl, like Sale.active.for_city(Toronto).above(5).any?

  # this is how we create an instance mthod in ruby
  def finished?
    self.ends_on < Date.current
    # also can do ends_on < Date.current. It can work without the 'self';
  end

  def upcoming?
    self.starts_on > Date.current
  end

  def active?
    !finished? && !upcoming?
    # ie. self.starts_on < Date.current && self.ends_on > Date.current;
  end
end
