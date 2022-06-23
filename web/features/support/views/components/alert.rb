class Alert
  include Capybara::DSL

  def dark
    find('.alert-dark').text
  end
end