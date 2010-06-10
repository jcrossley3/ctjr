module Cloud
  class Ec2

    def instances
      select_instances.map do |aws|
        Instance.new(
                     :id            => aws[:aws_instance_id], 
                     :image_id      => aws[:aws_image_id], 
                     :key_pair_name => aws[:ssh_key_name], 
                     :public_dns    => aws[:dns_name], 
                     :status        => aws[:aws_state]
                     )
      end
    end

    def select_instances
      client.describe_instances.select{|x| APP_CONFIG['image_ids'].include?(x[:aws_image_id])}
    end

    def launch image_id, key_pair_name
      client.launch_instances(image_id, :key_name => key_pair_name, :user_data => APP_CONFIG['user_data'])
    end

    def terminate instance_id
      client.terminate_instances [instance_id]
    end

    def client
      @client ||= Aws::Ec2.new(APP_CONFIG['access_key'], APP_CONFIG['secret_access_key'])
    end

  end
end