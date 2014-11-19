# Ajax testing with ruby and capybara
#
# Add this to spec/support
#
# When a link or button starts an ajax request, instead  of use Capybara
# click_link, click_button and click_link_or_button methods use click_ajax_link,
# click_ajax_button and click_ajax_link_or_button methods. You can still use
# capybara methods and right after it, call wait_for_ajax method.
#
# This methods will wait until Capybara.default_wait_time for the ajax request
# to finish before continue the normal tests flow.
#

require 'timeout'

module WaitForAjax
  def click_ajax_link(locator, options = {})
    click_link(locator, options)

    wait_for_ajax
  end

  def click_ajax_button(locator, options = {})
    click_button(locator, options)

    wait_for_ajax
  end

  def click_ajax_link_or_button(locator, options = {})
    click_link_or_button(locator, options)

    wait_for_ajax
  end

  def wait_for_ajax(&block)
    block.call if block

    Timeout.timeout(Capybara.default_wait_time) do
      loop do
        sleep 0.1
        break if finished_all_ajax_requests?
      end
    end
  end

  def finished_all_ajax_requests?
    page.evaluate_script('jQuery.active').zero?
  end
end

RSpec.configure do |config|
  config.include WaitForAjax
end