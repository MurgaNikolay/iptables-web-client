module IptablesWeb
  module Model
    class AccessRule < Base
      self.element_name = 'access_rule'

      MAPPING = {
        chain: 'INPUT',
        target_chain: 'ACCEPT',
        protocol: '-p {value}',
        port: '--dport {value}',
        ip: '-s {value}',
        description: '-m comment --comment "{value}"'
      }

      def to_s
        command = %w(-A INPUT)
        self.attributes.each do |name, value|

          case name.to_sym
            when :port
              next unless value
              if value.include?(',')
                command << '-m'
                command << 'multiport'
                command << '--dports'
                command << value
              else
                command << '--dport'
                command << value
              end
            when :ip
              command << '-s'
              command << value
            when :protocol
              command << '-p'
              command << value
            when :description
              if value
                command << '-m'
                command << 'comment'
                command << '--comment'
                command <<  Shellwords.escape(value)
              end
            else
              #skip
          end
        end
        command << '-j'
        command << 'ACCEPT'
        command.join(' ')
        # -A INPUT -s 88.150.233.48/29 -p tcp -m tcp --dport 9200 -j ACCEPT
      end

      def mapping(parameter)

      end
    end
  end
end

# *filter
# :INPUT ACCEPT [217626552:31573175391]
# :FORWARD ACCEPT [0:0]
# :OUTPUT ACCEPT [1334268962:861811554534]
# -A INPUT -s 88.150.233.48/29 -p tcp -m tcp --dport 9200 -j ACCEPT
# -A INPUT -s 88.150.213.250/32 -p tcp -m tcp --dport 9200 -j ACCEPT
# -A INPUT -s 127.0.0.1/32 -p tcp -m tcp --dport 9200 -j ACCEPT
# -A INPUT -s 37.220.8.122/32 -p tcp -m tcp --dport 9200 -j ACCEPT
# -A INPUT -p tcp -m tcp --dport 9200 -j DROP
# -A INPUT -s 88.150.233.48/29 -p tcp -m tcp --dport 9300 -j ACCEPT
# -A INPUT -s 88.150.213.250/32 -p tcp -m tcp --dport 9300 -j ACCEPT
# -A INPUT -p tcp -m tcp --dport 9300 -j DROP
# -A INPUT -s 193.105.70.192/29 -p tcp -m tcp --dport 22 -j ACCEPT
# -A INPUT -s 92.60.190.109/32 -p tcp -m tcp --dport 22 -j ACCEPT
# -A INPUT -p tcp -m tcp --dport 22 -j DROP
# COMMIT