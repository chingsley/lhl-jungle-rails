class Sale < ActiveRecord::Base

  # has_many :products

  validates :name, presence: true
  validates :starts_on, presence: true
  validates :ends_on, presence: true
  validates :percent_off, presence: true

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
