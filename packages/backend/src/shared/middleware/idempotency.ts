import { redis } from '../redis/client';

const LOCK_TTL = 120; // seconds

export async function acquireLock(key: string): Promise<boolean> {
  const result = await redis.set(`lock:payment:${key}`, 'processing', 'NX', 'EX', LOCK_TTL);
  return result === 'OK';
}

export async function releaseLock(key: string): Promise<void> {
  await redis.del(`lock:payment:${key}`);
}

export async function checkIdempotency(key: string): Promise<unknown | null> {
  const cached = await redis.get(`idempotency:${key}`);
  return cached ? JSON.parse(cached) : null;
}

export async function setIdempotency(key: string, response: unknown): Promise<void> {
  await redis.set(`idempotency:${key}`, JSON.stringify(response), 'EX', 86400);
}
