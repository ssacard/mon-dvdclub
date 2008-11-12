module DvdsHelper
  def categories
    @categories ||= DvdCategory.find(:all).collect{|c| [c.name, c.name]}
  end
end
