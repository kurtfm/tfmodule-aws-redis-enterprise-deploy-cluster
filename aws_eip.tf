# Resource: aws_eip (provides an elastic IP resource)
# EIPs will be used as the IP addresses in your DNS 
# and attached as the public IP address to each Redis Cluster EC2.

### RE Nodes EIP
resource "aws_eip" "re_cluster_instance_eip" {
  count = var.data-node-count
  network_border_group = var.region
  vpc      = true

  tags = {
      Name = format("%s-%s-eip-%s", var.base_name, var.region, count.index+1),
      Owner = var.owner
  }

}

# Elastic IP association
resource "aws_eip_association" "re-eip-assoc" {
  count = var.data-node-count
  instance_id   = element(aws_instance.re_cluster_instance.*.id, count.index)
  allocation_id = element(aws_eip.re_cluster_instance_eip.*.id, count.index)
  depends_on    = [aws_instance.re_cluster_instance, aws_eip.re_cluster_instance_eip]
}


### Benchmark Nodes EIP
resource "aws_eip" "test_node_eip" {
  count = var.test-node-count
  network_border_group = var.region
  vpc      = true

  tags = {
      Name = format("%s-%s-test-eip-%s", var.base_name, var.region, count.index+1),
      Owner = var.owner
  }

}

# Elastic IP association
resource "aws_eip_association" "test_eip_assoc" {
  count = var.test-node-count
  instance_id   = element(aws_instance.test_node.*.id, count.index)
  allocation_id = element(aws_eip.test_node_eip.*.id, count.index)
  depends_on    = [aws_instance.test_node, aws_eip.test_node_eip]
}
