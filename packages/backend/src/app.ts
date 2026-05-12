import Fastify from 'fastify';
import cors from '@fastify/cors';
import rateLimit from '@fastify/rate-limit';
import { config } from './config';
import { prisma } from './shared/db/client';
import { redis } from './shared/redis/client';

const app = Fastify({
  logger: config.nodeEnv !== 'test',
});

async function bootstrap() {
  await app.register(cors, { origin: config.cors.origin });
  await app.register(rateLimit, {
    max: config.rateLimit.max,
    timeWindow: config.rateLimit.windowMs,
  });

  app.get('/health', async () => ({
    status: 'ok',
    timestamp: new Date().toISOString(),
  }));

  try {
    await prisma.$connect();
    app.log.info('Database connected');
    await redis.ping();
    app.log.info('Redis connected');
  } catch (err) {
    app.log.error(err, 'Failed to connect to services');
  }

  return app;
}

async function start() {
  const app = await bootstrap();
  try {
    await app.listen({ port: config.port, host: config.host });
    app.log.info(`Server listening on ${config.host}:${config.port}`);
  } catch (err) {
    app.log.error(err);
    process.exit(1);
  }
}

start();

export { bootstrap, app };
