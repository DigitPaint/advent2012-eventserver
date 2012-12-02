require 'active_support'
require 'active_support/json'
require 'sys/cpu'

class LoadavgAction < Cramp::Action
  self.transport = :sse

  on_start :send_loadavg
  periodic_timer :send_loadavg, :every => 1

  def send_loadavg
    data = Sys::CPU.load_avg
    render data.to_json
  end
end