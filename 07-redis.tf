resource "aws_elasticache_subnet_group" "bugraid_noufa_redis_subnet_group" {
  name       = "bugraid-noufa-redis-subnet-group"
  subnet_ids = module.vpc.private_subnets

  tags = {
    Name        = "bugraid-noufa-redis-subnet-group"
    Environment = "bugraid-noufa"
    Project     = "bugraid-assignment"
  }
}

resource "aws_elasticache_cluster" "bugraid_noufa_redis" {
  cluster_id           = "bugraid-noufa-redis"
  engine               = "redis"
  engine_version       = "7.1"
  node_type            = "cache.t3.micro"
  num_cache_nodes      = 1
  parameter_group_name = "default.redis7"
  port                 = 6379

  subnet_group_name = aws_elasticache_subnet_group.bugraid_noufa_redis_subnet_group.name
  security_group_ids = [module.vpc.default_security_group_id]

  tags = {
    Name        = "bugraid-noufa-redis"
    Environment = "bugraid-noufa"
    Project     = "bugraid-assignment"
  }
}
