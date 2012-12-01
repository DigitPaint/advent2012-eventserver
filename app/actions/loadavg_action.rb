require 'active_support'
require 'active_support/json'
require 'sys/cpu'

class LoadavgAction < Cramp::Action
  self.transport = :sse

  on_start :send_latest_time
  periodic_timer :send_latest_time, :every => 1

  def send_latest_time
    # OS X code: out = `w | head -n1 | cut -d":" -f4`
    data = Sys::CPU.load_avg
    render data.to_json
  end
end