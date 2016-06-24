#
# Author:: Dangleterre Michaël
# © Copyright ArubaCloud.
#
# LICENSE: MIT (http://opensource.org/licenses/MIT)
#

require 'fog/arubacloud/service'
require 'fog/arubacloud/error'


module Fog
  module Compute
    class ArubaCloud
      class Real
        def create_scheduled_operation(data)
          body = {
              :NewSchedulePlan => {
                  :FirstExecutionTime => data[:dateStart],
                  :LastExecutionTime => data[:endDate],
                  :OperationType => data[:OperationType],
                  :ServerID => data[:ServerId],
                  :ScheduledPlanStatus => 'Enabled'
              }
          }
          self.request(
              body=body,
              method_name='SetAddServerScheduledOperation',
              failure_message='Error configuring Scheduled Operation.',
              benchmark=true
          )
        end # create_scheduled_operation
      end # Real

      class Mock
        def create_scheduled_operation
          raise Fog::Errors::MockNotImplemented.new(
              'Mock not implemented. Feel free to contribute.'
          )
        end # create_scheduled_operation
      end # Mock
    end # ArubaCloud
  end # Compute
end # Fog