#
# Author:: Dangleterre Michaël
# © Copyright ArubaCloud.
#
# LICENSE: MIT (http://opensource.org/licenses/MIT)
#

require 'fog/arubacloud/service'
require 'fog/arubacloud/error'
require 'benchmark'


module Fog
  module Compute
    class ArubaCloud
      class Real
        def create_loadbalancer(data)
          body = self.body('SetEnqueueLoadBalancerCreation').merge(
                :LoadBalancerCreationRequest => {
                    :HealthCheckNotification => data[:healthchecknotification],
                    :Name => data[:name],
                    :rules => [
                        :LoadBalancerRule => [
                            {
                                :BalanceType => data[:balancetype],
                                :Certificate => data[:certificate],
                                :CreationDate => data[:creationdate],
                                :ID => data[:ruleid],
                                :InstancePort => data[:instanceport],
                                :LoadBalancerPort => data[:loadbalancerport],
                                :Protocol => data[:protocol]
                            }
                        ]
                    ],
                    :ipAddressesResourceId => data[:ipaddressesresourceid],
                    :NotificationContacts => [
                        :NotificationContact => [
                            {
                                :ContactValue => data[:contacvalue],
                                :LoadBalancerContactID => data[:loadbalancercontactid],
                                :Type => data[:type]
                            }
                        ]
                    ]
                }
          )
          options = {
              :http_method => :post,
              :method => 'SetEnqueueLoadBalancerCreation',
              :body => Fog::JSON.encode(body)
          }

          response = nil
          time = Benchmark.realtime {
            response = request(options)
          }
          Fog::Logger.debug("SetEnqueueLoadBalancerCreation time: #{time}")
          if response['Success']
            response
          else
            raise Fog::ArubaCloud::Errors::RequestError.new('Error during the Load Balancer creation.')
          end

        end # create_loadbalancer
        class Mock
          def create_loadbalancer(data)
            response = Excon::Response.new
            response.status = 200
            response.body = {
                'ExceptionInfo' => nil,
                'ResultCode' => 0,
                'ResultMessage' => nil,
                'Success' => true
            }
            response.body
          end # create_loadbalancer
        end # Mock
      end # Real
    end # ArubaCloud
  end # Compute
end # Fog