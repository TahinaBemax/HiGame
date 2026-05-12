import { redis } from '../redis/client';
import { config } from '../../config';

export async function rateLimitMiddleware(identifier: string): Promise<{ allowed: boolean; remaining: number }> {
  const key = `rate:${identifier}`;
  const current = await redis.incr(key);

  if (current === 1) {
    await redis.pexpire(key, config.rateLimit.windowMs);
  }

  return {
    allowed: current <= config.rateLimit.max,
    remaining: Math.max(0, config.rateLimit.max - current),
  };
}
