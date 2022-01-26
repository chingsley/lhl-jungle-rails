class Sale < ActiveRecord::Base

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
