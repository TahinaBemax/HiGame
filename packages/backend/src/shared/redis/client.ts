import Redis from 'ioredis';
import { config } from '../../config';

export const redis = new Redis(config.redis.url, {
  retryStrategy: (times) => Math.min(times * 50, 2000),
  maxRetriesPerRequest: 3,
});
