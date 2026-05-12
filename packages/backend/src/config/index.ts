import dotenv from 'dotenv';
dotenv.config({ path: '../../.env' });

export const config = {
  nodeEnv: process.env.NODE_ENV || 'development',
  port: parseInt(process.env.PORT || '3000', 10),
  host: process.env.HOST || '0.0.0.0',
  database: {
    url: process.env.DATABASE_URL || 'postgresql://user:password@localhost:5432/higame',
  },
  redis: {
    url: process.env.REDIS_URL || 'redis://localhost:6379',
  },
  jwt: {
    secret: process.env.JWT_SECRET || 'dev-secret',
    expiresIn: process.env.JWT_EXPIRES_IN || '7d',
  },
  rateLimit: {
    windowMs: parseInt(process.env.RATE_LIMIT_WINDOW_MS || '60000', 10),
    max: parseInt(process.env.RATE_LIMIT_MAX || '100', 10),
  },
  kyc: {
    encryptionKey: process.env.KYC_ENCRYPTION_KEY || 'dev-encryption-key',
  },
  cors: {
    origin: process.env.CORS_ORIGIN || '*',
  },
} as const;
